#!/bin/bash

set -x
mkdir -p github.com/ultibohub
cd github.com/ultibohub
git clone https://github.com/ultibohub/Examples
cd Examples
set +x

INCLUDES=-Fi/root/ultibo/core/fpc/source/packages/fv/src

function build {
    echo message .......... building *.lpr for target $1
    rm -f *.o
    set -x
    fpc \
     -B \
     -Tultibo \
     -O2 \
     -Parm \
     $2 \
     $INCLUDES \
     @/root/ultibo/core/fpc/bin/$3 \
     *.lpr
    if [ "$?" != 0 ]
    then
        exit 1
    fi
    set +x
}

function build-QEMU {
    echo build QEMU "-CpARMV7A -WpQEMUVPB" qemuvpb.cfg
}

function build-RPi {
    build $1 "-CpARMV6 -WpRPIB" rpi.cfg
}

function build-RPi2 {
    build $1 "-CpARMV7A -WpRPI2B" rpi2.cfg
}

function build-RPi3 {
    build $1 "-CpARMV7A -WpRPI3B" rpi3.cfg
}

for f in [0-9][0-9]-*
do
    cd $f
    echo
    echo $f
    for g in *
    do
        cd $g
        build-$g $g
        cd ..
    done
    cd ..
done

rm -rf /root/github.com
