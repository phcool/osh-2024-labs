// server.c
#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <sys/stat.h>
#include <pthread.h>

#define BIND_IP_ADDR "127.0.0.1"
#define BIND_PORT 8000
#define MAX_RECV_LEN 1048576
#define MAX_SEND_LEN 1048576
#define MAX_PATH_LEN 1024
#define MAX_HOST_LEN 1024
#define MAX_CONN 100
#define BUFFER_SIZE 1000
#define BUF_SIZE 1000
#define PATH_MAX 300
#define THREAD_COUNT 20

#define HTTP_STATUS_200 "200 OK"
#define HTTP_STATUS_500 "500 Internal Server Error"
#define HTTP_STATUS_404 "404 Not Found"

typedef struct
{
    void *(*function)(int);
    int clnt_sock;
} Task;

typedef struct
{
    pthread_mutex_t lock;
    pthread_cond_t notify;
    pthread_t *threads;
    Task *queue;
    int thread_count;
    int queue_size;
    int head;
    int tail;
    int count;
    int shutdown;
} ThreadPool; // 线程池结构体

Task thread_pool_dequeue(ThreadPool *pool)
{
    Task task = pool->queue[pool->head];
    pool->head = (pool->head + 1) % pool->queue_size;
    pool->count--;
    return task;
}

void *thread_pool_worker(void *arg)
{
    ThreadPool *pool = (ThreadPool *)arg;
    while (1)
    {
        pthread_mutex_lock(&(pool->lock));

        // 等待新的任务
        while (pool->count == 0 && !pool->shutdown)
        {
            pthread_cond_wait(&(pool->notify), &(pool->lock));
        }

        // 退出
        if (pool->shutdown)
        {
            pthread_mutex_unlock(&(pool->lock));
            pthread_exit(NULL);
        }

        // 执行任务，出队列
        Task task = thread_pool_dequeue(pool);
        pthread_cond_signal(&(pool->notify));
        pthread_mutex_unlock(&(pool->lock));
        (*(task.function))(task.clnt_sock);
    }
    return NULL;
}

ThreadPool *thread_pool_create(int thread_count, int queue_size)
{
    ThreadPool *pool = (ThreadPool *)malloc(sizeof(ThreadPool));
    pool->thread_count = thread_count;
    pool->queue_size = queue_size;
    pool->head = 0;
    pool->tail = 0;
    pool->count = 0;
    pool->shutdown = 0;

    // 初始化互斥锁和条件变量
    pthread_mutex_init(&(pool->lock), NULL);
    pthread_cond_init(&(pool->notify), NULL);

    // 分配空间给线程和队列
    pool->threads = (pthread_t *)malloc(thread_count * sizeof(pthread_t));
    pool->queue = (Task *)malloc(queue_size * sizeof(Task));

    // 初始化线程，让线程执行worker函数，用于等待队列中的函数
    for (int i = 0; i < thread_count; ++i)
    {
        pthread_create(&(pool->threads[i]), NULL, thread_pool_worker, (void *)pool);
    }

    return pool;
}

void thread_pool_destroy(ThreadPool *pool)
{
    if (pool == NULL)
        return;
    pool->shutdown = 1;

    // 启动所有线程
    pthread_cond_broadcast(&(pool->notify));

    // 等待所有线程结束
    for (int i = 0; i < pool->thread_count; ++i)
    {
        pthread_join(pool->threads[i], NULL);
    }

    // 释放空间
    free(pool->threads);
    free(pool->queue);

    // 关闭互斥锁和条件变量
    pthread_mutex_destroy(&(pool->lock));
    pthread_cond_destroy(&(pool->notify));

    // 释放线程池空间
    free(pool);
}

void thread_pool_enqueue(ThreadPool *pool, void *(*function)(int), int clnt_sock)
{
    pthread_mutex_lock(&(pool->lock));

    // 如果队列已满，等待线程池处理队列
    while (pool->count == pool->queue_size)
    {
        pthread_cond_wait(&(pool->notify), &(pool->lock));
    }

    // 添加任务到队列中
    pool->queue[pool->tail].function = function;
    pool->queue[pool->tail].clnt_sock = clnt_sock;
    pool->tail = (pool->tail + 1) % pool->queue_size;
    pool->count++;

    pthread_cond_signal(&(pool->notify));

    pthread_mutex_unlock(&(pool->lock));
}

int parse_request(char *request, ssize_t req_len, char *path, ssize_t *path_len)
{
    char *req = request;
    int flag = 0;
    // 一个粗糙的解析方法，可能有 BUG！
    // 获取第一个空格 (s1) 和第二个空格 (s2) 之间的内容，为 PATH
    ssize_t s1 = 0;
    while (s1 < req_len)
    {
        if (req[s1] == ' ')
        {
            flag = 1;
            break;
        }
        s1++;
    }
    if (flag == 0)
    {
        *path_len = 0;
        path[0] = '\0';
        return 500;
    }
    req[s1] = '\0';
    char *s = "GET";
    if (strcmp(req, s) != 0)
    {
        return 500;
    }
    ssize_t s2 = s1 + 1;
    flag = 0;
    while (s2 < req_len)
    {
        if (req[s2] == ' ')
        {
            flag = 1;
            break;
        }
        s2++;
    }
    if (flag == 0)
    {
        return 500;
    }
    memcpy(path, req + s1 + 1, (s2 - s1 - 1) * sizeof(char));
    path[s2 - s1 - 1] = '\0';
    *path_len = (s2 - s1 - 1);
    return 200;
}

void *handle_clnt(int clnt_sock)
{
    int status = 200;
    // 一个粗糙的读取方法，可能有 BUG！
    // 读取客户端发送来的数据，并解析
    char *req_buf = NULL;
    // 将 clnt_sock 作为一个文件描述符，读取最多 MAX_RECV_LEN 个字符
    // 但一次读取并不保证已经将整个请求读取完整
    char buffer[BUFFER_SIZE]; // 缓冲区
    ssize_t bytes_read;
    ssize_t bytes_written;
    while ((bytes_read = read(clnt_sock, buffer, BUFFER_SIZE)) > 0)
    {
        int len;
        if (req_buf == NULL)
        {
            len = 0;
        }
        else
        {
            len = strlen(req_buf);
        }
        req_buf = realloc(req_buf, len + bytes_read + 1);
        req_buf[len] = 0;
        if (req_buf == NULL)
        {
            status = 500;
            break;
        }
        strncat(req_buf, buffer, bytes_read);
        if (strstr(buffer, "\r\n\r\n") != NULL)
        {
            // 包含空行，请求头结束，停止读取
            break;
        }
    }
    if (bytes_read == -1)
    {
        status = 500;
    }
    int req_len;
    if (req_buf != NULL)
    {
        req_len = strlen(req_buf);
    }
    else
    {
        req_len = 0;
    }
    // 根据 HTTP 请求的内容，解析资源路径和 Host 头
    char *path = (char *)malloc(MAX_PATH_LEN * sizeof(char));
    ssize_t path_len;
    status = parse_request(req_buf, req_len, path, &path_len);
    // 构造要返回的数据
    // 注意，响应头部后需要有一个多余换行（\r\n\r\n），然后才是响应内容
    char *response = (char *)malloc(MAX_SEND_LEN * sizeof(char));
    path++;
    path_len--;
    FILE *file = fopen(path, "r");
    char file_content[BUF_SIZE] = "";
    if (file == NULL)
    {
        status = 404;
    }
    else
    {
        char program_dir[PATH_MAX];
        if (getcwd(program_dir, sizeof(program_dir)) == NULL)
        {
            perror("getcwd failed");
            return NULL;
        }
        char absolute_path[PATH_MAX];
        if (realpath(path, absolute_path) == NULL)
        {
            perror("realpath failed");
            return NULL;
        }
        if (strstr(absolute_path, program_dir) != absolute_path)
        {
            status = 500;
        }
        struct stat file_stat;
        if (stat(path, &file_stat) == 0)
        {
            if (S_ISDIR(file_stat.st_mode))
            {
                status = 500;
            }
            else
            {
                status = 200;
                fread(file_content, 1, BUF_SIZE, file);
            }
        }
        else
        {
            perror("fail to get the file!");
            return NULL;
        }
    }
    if (file != NULL)
    {
        fclose(file);
    }
    char *resp;
    int file_length;
    switch (status)
    {
    case 200:
        file_length = strlen(file_content);
        sprintf(response,
                "HTTP/1.0 %s\r\nContent-Length: %d\r\n\r\n%s",
                HTTP_STATUS_200, file_length, file_content);
        break;
    case 404:
        sprintf(response,
                "HTTP/1.0 %s\r\nContent-Length: %zd\r\n\r\n%s",
                HTTP_STATUS_404, strlen(HTTP_STATUS_404), HTTP_STATUS_404);
        break;
    case 500:
        sprintf(response,
                "HTTP/1.0 %s\r\nContent-Length: %zd\r\n\r\n%s",
                HTTP_STATUS_500, strlen(HTTP_STATUS_500), HTTP_STATUS_500);
        break;
    default:
        sprintf(response,
                "HTTP/1.0 %s\r\nContent-Length: %zd\r\n\r\n%s",
                HTTP_STATUS_500, strlen(HTTP_STATUS_500), HTTP_STATUS_500);
        break;
    }
    size_t response_len = strlen(response);

    // 通过 clnt_sock 向客户端发送信息
    // 将 clnt_sock 作为文件描述符写内容
    bytes_written = 0;
    while (bytes_written < response_len)
    {
        ssize_t ret = write(clnt_sock, response + bytes_written, response_len - bytes_written);
        if (ret == -1)
        {
            perror("write");
            return NULL;
        }
        bytes_written += ret;
    }
    // 关闭客户端套接字
    close(clnt_sock);

    // 释放内存
    path--;
    free(req_buf);
    free(path);
    free(response);
}

int main()
{
    // 创建套接字，参数说明：
    //   AF_INET: 使用 IPv4
    //   SOCK_STREAM: 面向连接的数据传输方式
    //   IPPROTO_TCP: 使用 TCP 协议
    int serv_sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);

    // 将套接字和指定的 IP、端口绑定
    //   用 0 填充 serv_addr（它是一个 sockaddr_in 结构体）
    struct sockaddr_in serv_addr;
    memset(&serv_addr, 0, sizeof(serv_addr));
    //   设置 IPv4
    //   设置 IP 地址
    //   设置端口
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = inet_addr(BIND_IP_ADDR);
    serv_addr.sin_port = htons(BIND_PORT);
    //   绑定
    bind(serv_sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr));

    // 使得 serv_sock 套接字进入监听状态，开始等待客户端发起请求
    listen(serv_sock, MAX_CONN);

    ThreadPool *pool = thread_pool_create(THREAD_COUNT, MAX_CONN);
    // 接收客户端请求，获得一个可以与客户端通信的新的生成的套接字 clnt_sock
    struct sockaddr_in clnt_addr;
    socklen_t clnt_addr_size = sizeof(clnt_addr);

    while (1) // 一直循环
    {
        // 当没有客户端连接时，accept() 会阻塞程序执行，直到有客户端连接进来
        int clnt_sock = accept(serv_sock, (struct sockaddr *)&clnt_addr, &clnt_addr_size);
        // 处理客户端的请求

        if (clnt_sock == -1)
        {
            perror("pthread_create");
            close(clnt_sock);
            continue;
        }
        thread_pool_enqueue(pool, &handle_clnt, clnt_sock);
    }

    // 实际上这里的代码不可到达，可以在 while 循环中收到 SIGINT 信号时主动 break
    // 关闭套接字
    thread_pool_destroy(pool);
    close(serv_sock);
    return 0;
}