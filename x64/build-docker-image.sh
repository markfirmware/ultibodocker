#!/bin/bash
set -x

docker build -t markfirmware/ufpc . |& tee build.log
