#!/bin/bash
set -x

docker build -t markfirmware/ultibo . |& tee build.log
