#!/bin/bash
set -x

docker build -t markfirmware/ultibodockerx64 . |& tee build.log
