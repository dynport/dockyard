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
    nginx       # 1.4.1
    redis       # 2.6.13
    postgresql  # 9.2.4
    memcached   # 1.4.15
