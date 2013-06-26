# Dockyard

Dockyard makes it easy to compile speicifc versions of popular linux tools (like ruby, nginx, etc.) form source. It is intended to be used when building docker containers but could be also used to install those tools on any other supported system.

## Requirements

Dockyard i stargeted for Ubuntu based operating systems and requires `bash`. To get in on the system where it should be used `curl` is recommended.

Dockyard is

* tested using Ubuntu 12.04 LTS
* will probably run with other Ubuntu versions
* could run on other debian based linux distributions
* will not run on non-debian based linux distributions

## Basic Usage

    $ ./bin/dockyard build nginx 1.4.1 -f ubuntu:12.04 # generate a dockerfile
    FROM ubuntu:12.04
    RUN sed 's/main$/universe main/' -i /etc/apt/sources.list && apt-get update && apt-get upgrade -y
    RUN apt-get install -y build-essential curl
    RUN curl -s -o /tmp/nginx-1.4.1.tar.gz.tmp http://nginx.org/download/nginx-1.4.1.tar.gz && mv /tmp/nginx-1.4.1.tar.gz.tmp
    /tmp/nginx-1.4.1.tar.gz
    RUN DEBIAN_FRONTEND=noninteractive apt-get install -y unzip libpcre3 libpcre3-dev libssl-dev libpcrecpp0 zlib1g-dev
    libgd2-xpm-dev
    RUN cd /tmp && tar xfz nginx-1.4.1.tar.gz
    RUN mkdir -p /tmp/nginx_syslog_patch && curl -s -o /tmp/nginx_syslog_patch/config.tmp
    https://raw.github.com/yaoweibin/nginx_syslog_patch/master/config && mv /tmp/nginx_syslog_patch/config.tmp
    /tmp/nginx_syslog_patch/config
    RUN mkdir -p /tmp/nginx_syslog_patch && curl -s -o /tmp/nginx_syslog_patch/syslog_1.3.14.patch.tmp
    https://raw.github.com/yaoweibin/nginx_syslog_patch/master/syslog_1.3.14.patch && mv
    /tmp/nginx_syslog_patch/syslog_1.3.14.patch.tmp /tmp/nginx_syslog_patch/syslog_1.3.14.patch
    RUN cd /tmp/nginx-1.4.1 && patch -p1 < /tmp/nginx_syslog_patch/syslog_1.3.14.patch
    RUN cd /tmp/nginx-1.4.1 && ./configure --with-http_ssl_module --with-http_spdy_module --with-http_gzip_static_module
    --with-http_stub_status_module --add-module=/tmp/nginx_syslog_patch
    RUN cd /tmp/nginx-1.4.1 && make
    RUN cd /tmp/nginx-1.4.1 && make install
