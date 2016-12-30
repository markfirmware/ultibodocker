FROM frolvlad/alpine-fpc

RUN cd /root && \
    apk update && \
    apk add ca-certificates wget && \
    update-ca-certificates && \
    wget -q https://github.com/ultibohub/FPC/archive/master.zip && \
    ls

RUN cd /root && \
    mkdir -p ultibo/core && \
    cd ultibo/core && \
    unzip -q ../../master.zip && \
    mv FPC-master fpc && \
    ls

RUN cd /root/ultibo/core && \
    wget -q https://github.com/ultibohub/Core/archive/master.zip && \
    unzip -q master.zip && \
    mv Core-master/source/rtl/ultibo /root/ultibo/core/fpc/source/rtl && \
    mkdir -p /root/ultibo/core/fpc/source/packages && \
    mv Core-master/source/packages/ultibounits /root/ultibo/core/fpc/source/packages && \
    ls /root/ultibo/core/fpc/source/packages/ultibounits

RUN apk add build-base

RUN cd /root/ultibo/core/fpc/source && \
    make distclean && \
    ls

#RUN cd /root && \
#    echo '#!/bin/bash' > /usr/bin/i386-linux-ld && \
#    echo 'ld -A elf32-i386 $@' >> /usr/bin/i386-linux-ld && \
#    chmod +x /usr/bin/i386-linux-ld && \
#    which i386-linux-ld && \
#    echo '#!/bin/bash' > /usr/bin/i386-linux-as && \
#    echo 'as --32 $@' >> /usr/bin/i386-linux-as && \
#    chmod +x /usr/bin/i386-linux-as && \
#    which i386-linux-as

RUN cd /root/ultibo/core/fpc/source && \
    make all
