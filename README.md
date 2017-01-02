# Ultibo fpc installed in a docker image
Edition|Build|Size|Version|Stars|Pulls|Docker Hub
---|---|---|---|---|---|---
x86-64|[![Codefresh build status](https://g.codefresh.io/api/badges/build?branch=master&repoName=ultibodocker&repoOwner=markfirmware&pipelineName=ultibodocker&accountName=markfirmware)](https://g.codefresh.io/repositories/markfirmware/ultibodocker/builds?filter=trigger:build) | [![](https://images.microbadger.com/badges/image/markfirmware/ufpc.svg)](https://microbadger.com/images/markfirmware/ufpc "Get your own image badge on microbadger.com") | [![](https://images.microbadger.com/badges/version/markfirmware/ufpc.svg)](https://microbadger.com/images/markfirmware/ufpc "Get your own version badge on microbadger.com") | [![Docker Stars](https://img.shields.io/docker/stars/markfirmware/ufpc.svg?style=flat-square)](https://hub.docker.com/r/markfirmware/ufpc/) | [![Docker Pulls](https://img.shields.io/docker/pulls/markfirmware/ufpc.svg?style=flat-square)](https://hub.docker.com/r/markfirmware/ufpc/) | [ufpc](https://hub.docker.com/r/markfirmware/ufpc/)
arm7hf|[![Codefresh build status](https://g.codefresh.io/api/badges/build?branch=arm7hf&repoName=ultibodocker&repoOwner=markfirmware&pipelineName=ultibodocker&accountName=markfirmware)](https://g.codefresh.io/repositories/markfirmware/ultibodocker/builds?filter=trigger:build) | [![](https://images.microbadger.com/badges/image/markfirmware/ufpcarm.svg)](https://microbadger.com/images/markfirmware/ufpcarm "Get your own image badge on microbadger.com") | [![](https://images.microbadger.com/badges/version/markfirmware/ufpcarm.svg)](https://microbadger.com/images/markfirmware/ufpcarm "Get your own version badge on microbadger.com") | [![Docker Stars](https://img.shields.io/docker/stars/markfirmware/ufpcarm.svg?style=flat-square)](https://hub.docker.com/r/markfirmware/ufpcarm/) | [![Docker Pulls](https://img.shields.io/docker/pulls/markfirmware/ufpcarm.svg?style=flat-square)](https://hub.docker.com/r/markfirmware/ufpcarm/) | [ufpcarm](https://hub.docker.com/r/markfirmware/ufpcarm/)
## Status - Working - .img produced but not yet tested

See [issues](https://github.com/markfirmware/ultibodocker/issues)

* [x] build image with stock fpc 3.0.0
* [x] download and prepare ultibo fpc and core
* [x] compile ultibo fpc as x86-64
* [x] compile ultibo fpc as x86-64 cross arm
* [x] compile ultibo rtl/packages/etc
* [x] compile test app
* [ ] test kernel.bin using qemu
* [ ] test kernel7.img using rpi3

## Usage

Install docker. The docker run command will pull the docker image from docker hub the first time it is used.
```
# (edit rpi2 project.lpr in current directory)
docker run -v $(pwd):/workdir markfirmware/ufpc \
 -B -Tultibo -O2 -Parm -CpARMV7A -WpRPI2B @/root/ultibo/core/fpc/bin/rpi2.cfg \
 project.lpr
```

## Road Map

* docker image for arm (e.g. raspbian)
* include lazarus?

That is all
