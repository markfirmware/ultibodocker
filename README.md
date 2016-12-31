# Docker installation of Ultibo for an x86_64 host

[![Codefresh build status](https://g.codefresh.io/api/badges/build?branch=master&repoName=ultibodockerx64&repoOwner=markfirmware&pipelineName=ultibodockerx64&accountName=markfirmware)](https://g.codefresh.io/repositories/markfirmware/ultibodockerx64/builds?filter=trigger:build)

[![Docker Stars](https://img.shields.io/docker/stars/markfirmware/ultibodockerx64.svg?style=flat-square)](https://hub.docker.com/r/markfirmware/ultibodockerx64/)
[![Docker Pulls](https://img.shields.io/docker/pulls/markfirmware/ultibodockerx64.svg?style=flat-square)](https://hub.docker.com/r/markfirmware/ultibodockerx64/)

[Image at Docker Hub](https://hub.docker.com/r/markfirmware/ultibodockerx64/)

## Status - Almost Working - Producing .elf instead of .img

See [issues](https://github.com/markfirmware/ultibodockerx64/issues)

* [x] build image with stock fpc 3.0.0
* [x] download and prepare ultibo fpc and core
* [x] compile ultibo fpc as x86-64
* [x] compile ultibo rtl/packages/etc
* [ ] compile test app - compiles but produces .elf instead of .img

## Usage

Install docker. The docker run command will pull the docker image from docker hub the first time it is used.
```
# (edit program.lpr in current directory)
docker run --rm -v $PWD:/tmp markfirmware/ultibodockerx64:master /root/ultibo/core/fpc/bin/fpcrpi3 /tmp/program.lpr
```

## Road Map

* docker image for arm (e.g. raspbian)

That is all
