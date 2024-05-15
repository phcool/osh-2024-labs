mkdir -p /tmp/webroot && cd / tmp/webroot
echo "Hello from Python Server" > hello.html

python2 -m SimpleHTTPServer
