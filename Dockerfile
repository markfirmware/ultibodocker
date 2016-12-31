FROM philcryer/min-jessie

RUN cd /root && \
    apt-get update && \
    apt-get install -y wget && \
    wget 'http://downloads.sourceforge.net/project/lazarus/Lazarus%20Linux%20amd64%20DEB/Lazarus%201.6.2/fpc_3.0.0-151205_amd64.deb?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Flazarus%2Ffiles%2FLazarus%2520Linux%2520amd64%2520DEB%2FLazarus%25201.6.2%2F&ts=1483204950&use_mirror=superb-sea2' && \
    ls

RUN cd /root && \
    ls && \
    dpkg -i fpc_3.0.0-151205_amd64.deb && \
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
