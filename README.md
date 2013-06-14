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

### Setup

    apt-get install curl -y
    curl -o /usr/local/bin/dockyard https://raw.github.com/dynport/dockyard/master/dockyard
    chmod 0755 /usr/local/bin/dockyard

### Installing packages
    dockyard install redis 2.6.13

## Dockerfile example
    # /tmp/redis.dockerfile
    FROM ubuntu:12.04

    # changing this field can be used to force a re-download of the dockyard script
    ENV BUILT_ON 2013-06-09

    RUN apt-get update && apt-get install curl -y
    RUN curl https://raw.github.com/dynport/dockyard/master/dockyard -o /usr/local/bin/dockyard && chmod 0755 /usr/local/bin/dockyard

    ENV REDIS_VERSION 2.6.13
    RUN dockyard install redis $REDIS_VERSION

    EXPOSE 6379

    CMD redis-server

And then execute with:

    cat /tmp/redis.dockerfile | docker build -t dockyard:redis-2.6.13 -

## Available recipes (with most recent versions)

    ruby        # 2.0.0-p195
    jruby       # 1.7.4
    nginx       # 1.4.1
    redis       # 2.6.13
    postgresql  # 9.2.4
    memcached   # 1.4.15

## Testing

You can use the script `bin/remote_test` to test changes to your local dockyard file.
You need to have ruby >= 1.9 and the bundler gem installed.

    bundle
    bundle exec ruby bin/remote_test -h docker.host redis 2.6.13

`docker.host` must be a remote host where docker is running.

For the initial test a image `dockyard::sshd` is created which is used for all test runs. Your public ssh key will be copied to that image as well (default location is ~/id_rsa.pub but you can provide an alternative one using the -i flag).

For each test a new containers is launched with the sshd image to which the local dockyard file is uploaded and in which the
dockyard command is executed with the provided parameters.

### Using a proxy

To speed up testing the same recipes (and to save network bandwidth) you can use a squid proxy running on the docker root system
at http://172.16.42.1:3128 using the `--proxy` flag.

Here are some useful squid config settings:


    # allow access from the private docker network
    acl allowed_ips src 172.16.0.0-172.16.254.254
    http_access allow allowed_ips

    # use proper cache sizes
    maximum_object_size_in_memory 8192 KB
    maximum_object_size 200000 KB

    # 2048 MB in 16/256 levels (defaut)
    cache_dir ufs /var/spool/squid3 2048 16 256

    # enable access logs
    access_log /var/log/squid3/access.log squid

    # cache everything for 24-72h
    refresh_pattern .               1440    20%     4320 override-expire override-lastmod reload-into-ims ignore-reload ignore-no-cache ignore-private ignore-auth
