FROM philcryer/min-jessie

RUN cd /root && \
    echo 'deb http://httpredir.debian.org/debian experimental main' > /etc/apt/sources.list
    apt-get update && \
    apt-get install fpc && \
    fpc

RUN cd /root && \
    wget -q https://github.com/ultibohub/FPC/archive/master.zip && \
    mkdir -p ultibo/core && \
    cd ultibo/core && \
    unzip -q ../../master.zip && \
    mv FPC-master fpc && \
    ls

RUN cd /root/ultibo/core && \
    wget -q https://github.com/ultibohub/Core/archive/master.zip && \
    unzip -q master.zip && \
    mkdir -p /root/ultibo/core/fpc/source/packages && \
    mv Core-master/source/rtl/ultibo /root/ultibo/core/fpc/source/rtl && \
    mv Core-master/source/packages/ultibounits /root/ultibo/core/fpc/source/packages && \
    mv Core-master/units /root/ultibo/core/fpc && \
    ls /root/ultibo/core/fpc/source/packages/ultibounits

RUN cd /root/ultibo/core/fpc/source && \
    make distclean && \
    ls

RUN cd /root/ultibo/core/fpc/source && \
    make all OS_TARGET=linux CPU_TARGET=x86_64
