#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <fcntl.h>
#include <errno.h>
#include <signal.h>

#define MAX_CMDLINE_LENGTH 1024 /* max cmdline length in a line*/
#define MAX_BUF_SIZE 4096       /* max buffer size */
#define MAX_CMD_ARG_NUM 32      /* max number of single command args */
#define WRITE_END 1             // pipe write end
#define READ_END 0              // pipe read end

#define MAX_PATH_LENGTH 255 // 最大路径长度

// 存储后台进程的 PID
pid_t background_processes[128];
int background_processes_count = 0;


//基于分隔符sep对于string做分割，并去掉头尾的空格
void add_background_process(pid_t pid);

int split_string(char *string, char *sep, char **string_clips)
{

    char string_dup[MAX_BUF_SIZE];
    string_clips[0] = strtok(string, sep);
    int clip_num = 0;

    do
    {
        char *head, *tail;
        head = string_clips[clip_num];
        tail = head + strlen(string_clips[clip_num]) - 1;
        while (*head == ' ' && head != tail)
            head++;
        while (*tail == ' ' && tail != head)
            tail--;
        *(tail + 1) = '\0';
        string_clips[clip_num] = head;
        clip_num++;
    } while (string_clips[clip_num] = strtok(NULL, sep));
    return clip_num;
}

//执行内置命令
int exec_builtin(int argc, char **argv, int *fd)
{
    if (argc == 0)
    {
        return 0;
    }

    if (strcmp(argv[0], "cd") == 0)
    {
        if (argv[1] == NULL)
        {
            chdir("/home");
        }
        else
        {
            if (chdir(argv[1]) != 0)
            {
                perror("chdir");
            }
        }
    }
    else if (strcmp(argv[0], "exit") == 0)
    {
        exit(0);
    }
    else if (strcmp(argv[0], "wait") == 0)
    {
        // 用户输入了 wait 命令，等待后台进程完成
        wait_background_processes();
    }
    else if (strcmp(argv[0], "fg") == 0)
    {
        // 前台执行指定的进程
        pid_t pid;
        if (argv[1] != NULL)
        {
            pid = atoi(argv[1]);
        }
        else
        {
            // 没有指定 PID，将最近启动的进程移到前台
            pid =background_processes[background_processes_count-1];
        }
        // 将指定 PID 的进程移到前台
        if (pid > 0)
        {
            kill(pid, SIGCONT);
            // 等待进程结束
            waitpid(pid, NULL, 0);
        }
    }
    else if (strcmp(argv[0], "bg") == 0)
    {
        // 后台执行指定的进程
        pid_t pid;
        if (argv[1] != NULL)
        {
            pid = atoi(argv[1]);
        }
        else
        {
            // 没有指定 PID，恢复最近启动的进程
            pid =background_processes[background_processes_count-1];
        }
        // 恢复指定 PID 的进程
        if (pid > 0)
        {
            kill(pid, SIGCONT);
        }
    }
    else
    {
        // 不是内置指令时
        return -1;
    }
    return 0;
}

/*
    从argv中删除重定向符和随后的参数，并打开对应的文件，将文件描述符放在fd数组中。
    运行后，fd[0]读端的文件描述符，fd[1]是写端的文件描述符
*/
int process_redirect(int argc, char **argv, int *fd)
{
    /* 默认输入输出到命令行，即输入STDIN_FILENO，输出STDOUT_FILENO */
    fd[READ_END] = STDIN_FILENO;
    fd[WRITE_END] = STDOUT_FILENO;
    int i = 0, j = 0;
    while (i < argc)
    {
        int tfd;
        if (strcmp(argv[i], ">") == 0)
        {
            tfd = open(argv[i + 1], O_WRONLY | O_CREAT | O_TRUNC, 0666);
            if (tfd < 0)
            {
                printf("open '%s' error: %s\n", argv[i + 1], strerror(errno));
            }
            else
            {
                fd[WRITE_END] = tfd;
            }
            i += 2;
        }
        else if (strcmp(argv[i], ">>") == 0)
        {
            tfd = open(argv[i + 1], O_WRONLY | O_CREAT | O_APPEND, 0666);
            if (tfd < 0)
            {
                printf("open '%s' error: %s\n", argv[i + 1], strerror(errno));
            }
            else
            {
                fd[WRITE_END] = tfd;
            }
            i += 2;
        }
        else if (strcmp(argv[i], "<") == 0)
        {
            tfd = open(argv[i + 1], O_RDONLY, 0666);
            if (tfd < 0)
            {
                printf("open '%s' error: %s\n", argv[i + 1], strerror(errno));
            }
            else
            {
                fd[READ_END] = tfd;
            }
            i += 2;
        }
        else
        {
            argv[j++] = argv[i++];
        }
    }
    argv[j] = NULL;
    return j; // 新的argc
}

/*
    在本进程中执行，且执行完毕后结束进程。
*/
int execute(int argc, char **argv)
{
    int fd[2];
    // 默认输入输出到命令行，即输入STDIN_FILENO，输出STDOUT_FILENO
    fd[READ_END] = STDIN_FILENO;
    fd[WRITE_END] = STDOUT_FILENO;
    // 处理重定向符
    argc = process_redirect(argc, argv, fd);
    if (exec_builtin(argc, argv, fd) == 0)
    {
        exit(0);
    }
    // 将标准输入输出STDIN_FILENO和STDOUT_FILENO修改为fd对应的文件
    dup2(fd[READ_END], STDIN_FILENO);
    dup2(fd[WRITE_END], STDOUT_FILENO);

    execvp(argv[0], argv);
    perror(argv[0]);
    exit(0);
    return 1;
}

void sigint_handler(int signum)
{
    printf("\n$ ");
    fflush(stdout);
}

void sigchld_handler_wait(int signum) {
    int status;
    pid_t pid;
    // 等待任何一个子进程结束
    while ((pid = waitpid(-1, &status, WNOHANG)) > 0) {
        // 在后台进程列表中查找并移除已经结束的进程
        for (int i = 0; i < background_processes_count; i++) {
            if (background_processes[i] == pid) {
                for (int j = i; j < background_processes_count - 1; j++) {
                    background_processes[j] = background_processes[j + 1];
                }
                background_processes_count--;
                break;
            }
        }
    }
}

void init_signal()
{
    signal(SIGINT, sigint_handler);
    signal(SIGCHLD, sigchld_handler_wait);
}

void wait_background_processes()
{
    for (int i = 0; i < background_processes_count; i++) {
        waitpid(background_processes[i], NULL, 0);
    }
}

void add_background_process(pid_t pid) {
    background_processes[background_processes_count++] = pid;
}


int main()
{
    init_signal(); // 初始化信号处理函数

    char path[MAX_PATH_LENGTH];
    /* 输入的命令行 */
    char inputline[MAX_CMDLINE_LENGTH];
    char *all_cmd[128];

    char cmdline[MAX_CMDLINE_LENGTH];
    char *commands[128];
    int cmd_count, all_cmd_count;
    while (1)
    {
        printf("$ ");

        fgets(inputline, 256, stdin);
        strtok(inputline, "\n");

        all_cmd_count = split_string(inputline, ";", all_cmd);
        for (int index = 0; index < all_cmd_count; index++)
        {
            strcpy(cmdline, all_cmd[index]);

            // 检查命令行是否以 '&' 结尾
            int background = 0;
            if (cmdline[strlen(cmdline) - 1] == '&')
            {
                background = 1;
                // 去除命令行末尾的 '&'
                cmdline[strlen(cmdline) - 1] = '\0';
            }

            /* 由管道操作符'|'分割的命令行各个部分，每个部分是一条命令 */
            cmd_count = split_string(cmdline, "|", commands);
            if (cmdline[0] == '\n')
            {
                cmd_count = 0;
            }

            if (cmd_count == 0)
            {
                continue;
            }
            else if (cmd_count == 1)
            { // 没有管道的单一命令
                char *argv[MAX_CMD_ARG_NUM];
                int argc;
                int fd[2];
                /* 在没有管道时，内建命令直接在主进程中完成，外部命令通过创建子进程完成 */
                argc = split_string(commands[0], " ", argv);
                if (exec_builtin(argc, argv, fd) == 0)
                {
                    continue;
                }
                pid_t pid = fork();
                if (pid == 0) // child
                {
                    // 在子进程中执行命令
                    execute(argc, argv);
                    exit(255);
                }
                else
                {
                    add_background_process(pid);
                    // 如果是后台执行，则不等待子进程结束
                    if (!background)
                    {
                        wait(NULL);
                    }
                }
            }
            else if (cmd_count == 2)
            { // 两个命令间的管道
                int pipefd[2];
                int ret = pipe(pipefd);
                if (ret < 0)
                {
                    printf("pipe error!\n");
                    continue;
                }
                // 子进程1
                int pid = fork();
                add_background_process(pid);
                if (pid == 0)
                {
                    close(pipefd[READ_END]);                // 关闭读端
                    dup2(pipefd[WRITE_END], STDOUT_FILENO); // 重定向写端
                    close(pipefd[WRITE_END]);
                    char *argv[MAX_CMD_ARG_NUM];

                    int argc = split_string(commands[0], " ", argv);
                    execute(argc, argv);
                    exit(255);
                }
                // 子进程2
                pid = fork();
                add_background_process(pid);
                if (pid == 0)
                {
                    close(pipefd[WRITE_END]);
                    dup2(pipefd[READ_END], STDIN_FILENO);
                    close(pipefd[READ_END]);

                    char *argv[MAX_CMD_ARG_NUM];
                    int argc = split_string(commands[1], " ", argv);
                    execute(argc, argv);
                    exit(255);
                }
                close(pipefd[WRITE_END]);
                close(pipefd[READ_END]);
                while (wait(NULL) > 0)
                    ;
            }
            else
            {
                int read_fd; // 上一个管道的读端口（出口）
                for (int i = 0; i < cmd_count; i++)
                {

                    int pipefd[2];
                    if (i != cmd_count - 1)
                    {
                        int ret = pipe(pipefd);
                        if (ret < 0)
                        {
                            printf("pipe error!\n");
                            continue;
                        }
                    }

                    int pid = fork();
                    add_background_process(pid);
                    if (pid == 0)
                    {
                        /* 除了最后一条命令外，都将标准输出重定向到当前管道入口 */
                        if (i != cmd_count - 1)
                            dup2(pipefd[WRITE_END], STDOUT_FILENO);

                        /* 除了第一条命令外，都将标准输入重定向到上一个管道出口 */
                        if (i != 0)
                            dup2(read_fd, STDIN_FILENO);

                        /* 处理参数，分出命令名和参数，并使用execute运行
                        */
                        char *argv[MAX_CMD_ARG_NUM];
                        int argc = split_string(commands[i], " ", argv);
                        execute(argc, argv);
                        exit(255);
                    }
                    /* 父进程除了第一条命令，都需要关闭当前命令用完的上一个管道读端口
                     * 父进程除了最后一条命令，都需要保存当前命令的管道读端口
                      */

                    read_fd = pipefd[READ_END];
                    close(pipefd[WRITE_END]);
                }
                while (wait(NULL) > 0)
                    ;
            }
        }
    }
}
