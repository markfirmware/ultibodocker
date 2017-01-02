# Docker installation of Ultibo for an x86_64 host

[![Codefresh build status](https://g.codefresh.io/api/badges/build?branch=master&repoName=ultibodockerx64&repoOwner=markfirmware&pipelineName=ultibodockerx64&accountName=markfirmware)](https://g.codefresh.io/repositories/markfirmware/ultibodockerx64/builds?filter=trigger:build)
[![](https://images.microbadger.com/badges/image/markfirmware/ultibodockerx64:master.svg)](https://microbadger.com/images/markfirmware/ultibodockerx64:master "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/markfirmware/ultibodockerx64:master.svg)](https://microbadger.com/images/markfirmware/ultibodockerx64:master "Get your own version badge on microbadger.com")
[![Docker Stars](https://img.shields.io/docker/stars/markfirmware/ultibodockerx64.svg?style=flat-square)](https://hub.docker.com/r/markfirmware/ultibodockerx64/)
[![Docker Pulls](https://img.shields.io/docker/pulls/markfirmware/ultibodockerx64.svg?style=flat-square)](https://hub.docker.com/r/markfirmware/ultibodockerx64/)

[![Codefresh build status](https://g.codefresh.io/api/badges/build?branch=arm7hf&repoName=ultibodockerx64&repoOwner=markfirmware&pipelineName=ultibodockerx64&accountName=markfirmware)](https://g.codefresh.io/repositories/markfirmware/ultibodockerx64/builds?filter=trigger:build)
[![](https://images.microbadger.com/badges/image/markfirmware/ufpcarm.svg)](https://microbadger.com/images/markfirmware/ufpcarm "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/markfirmware/ufpcarm.svg)](https://microbadger.com/images/markfirmware/ufpcarm "Get your own version badge on microbadger.com")
[![Docker Stars](https://img.shields.io/docker/stars/markfirmware/ultibodockerx64.svg?style=flat-square)](https://hub.docker.com/r/markfirmware/ultibodockerx64/)
[![Docker Pulls](https://img.shields.io/docker/pulls/markfirmware/ultibodockerx64.svg?style=flat-square)](https://hub.docker.com/r/markfirmware/ultibodockerx64/)

[Image at Docker Hub](https://hub.docker.com/r/markfirmware/ultibodockerx64/)

## Status - Working - .img produced but not yet tested

See [issues](https://github.com/markfirmware/ultibodockerx64/issues)

* [x] build image with stock fpc 3.0.0
* [x] download and prepare ultibo fpc and core
* [x] compile ultibo fpc as x86-64
* [x] compile ultibo rtl/packages/etc
* [x] compile test app
* [ ] test kernel.bin using qemu
* [ ] test kernel7.img using rpi3

## Usage

Install docker. The docker run command will pull the docker image from docker hub the first time it is used.
```
# (edit rpi2 project.lpr in current directory)
docker run -v $(pwd):/workdir markfirmware/ultibodockerx64:master \
 -B -Tultibo -O2 -Parm -CpARMV7A -WpRPI2B @/root/ultibo/core/fpc/bin/rpi2.cfg \
 project.lpr
```

## Road Map

* docker image for arm (e.g. raspbian)
* include lazarus?

That is all
