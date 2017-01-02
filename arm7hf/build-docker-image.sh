#!/bin/bash
set -x

docker build -t markfirmware/ufpcarm . |& tee build.log
