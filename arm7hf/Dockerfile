FROM resin/armv7hf-debian-qemu

RUN [ "cross-build-start" ]

WORKDIR /root

RUN apt-get update && apt-get install -y libgtk2.0-dev
RUN apt-get update && apt-get install -y wget binutils gcc bzip2 libc-dev make unzip libghc-x11-dev curl binutils-arm-none-eabi

COPY install.fpc-3.0.raspberry.sh .
RUN ./install.fpc-3.0.raspberry.sh
ENV PATH=/root/Development/FreePascal/fpc/bin:$PATH

RUN fpc -i && \
\
    wget -q https://github.com/ultibohub/FPC/archive/master.zip && \
    unzip -q master.zip && \
    rm master.zip && \
    mkdir -p /root/ultibo/core && \
    mv FPC-master /root/ultibo/core/fpc && \
    wget -q https://github.com/ultibohub/Core/archive/master.zip && \
    unzip -q master.zip && \
    rm master.zip && \
    mkdir -p /root/ultibo/core/fpc/source/packages && \
    mv Core-master/source/rtl/ultibo /root/ultibo/core/fpc/source/rtl && \
    mv Core-master/source/packages/ultibounits /root/ultibo/core/fpc/source/packages && \
    mv Core-master/units /root/ultibo/core/fpc && \
    rm -rf Core-master

WORKDIR /root/ultibo/core/fpc/source

RUN make distclean && \
    make all OPT=-dFPC_ARMHF && \
    make install OPT=-dFPC_ARMHF PREFIX=/root/ultibo/core/fpc && \
    cp /root/ultibo/core/fpc/source/compiler/ppcarm /root/ultibo/core/fpc/bin && \
    /root/ultibo/core/fpc/bin/fpcmkcfg -d basepath=/root/ultibo/core/fpc/lib/fpc/3.1.1 -o /root/ultibo/core/fpc/bin/fpc.cfg

ENV PATH=/root/ultibo/core/fpc/bin:$PATH

RUN fpc -i && \
    cd /root/ultibo/core/fpc/bin && \
\
    touch rpi.cfg  && \
    echo '#' >> rpi.cfg  && \
    echo '# Raspberry Pi (A/B/A+/B+/Zero) specific config file' >> rpi.cfg  && \
    echo '#' >> rpi.cfg  && \
    echo '-CfVFPV2' >> rpi.cfg  && \
    echo '-CIARM' >> rpi.cfg  && \
    echo '-CaEABIHF' >> rpi.cfg  && \
    echo '-OoFASTMATH' >> rpi.cfg  && \
    echo '-Fu/root/ultibo/core/fpc/units/armv6-ultibo/rtl' >> rpi.cfg  && \
    echo '-Fu/root/ultibo/core/fpc/units/armv6-ultibo/packages' >> rpi.cfg  && \
    echo '-Fl/root/ultibo/core/fpc/units/armv6-ultibo/lib' >> rpi.cfg  && \
\ 
    touch rpi2.cfg  && \
    echo '#' >> rpi2.cfg  && \
    echo '# Raspberry Pi 2B specific config file' >> rpi2.cfg  && \
    echo '#' >> rpi2.cfg  && \
    echo '-CfVFPV3' >> rpi2.cfg  && \
    echo '-CIARM' >> rpi2.cfg  && \
    echo '-CaEABIHF' >> rpi2.cfg  && \
    echo '-OoFASTMATH' >> rpi2.cfg  && \
    echo '-Fu/root/ultibo/core/fpc/units/armv7-ultibo/rtl' >> rpi2.cfg  && \
    echo '-Fu/root/ultibo/core/fpc/units/armv7-ultibo/packages' >> rpi2.cfg  && \
    echo '-Fl/root/ultibo/core/fpc/units/armv7-ultibo/lib' >> rpi2.cfg  && \
\
    touch rpi3.cfg  && \
    echo '#' >> rpi3.cfg && \
    echo '# Raspberry Pi 3B specific config file' >> rpi3.cfg && \
    echo '#' >> rpi3.cfg && \
    echo '-CfVFPV3' >> rpi3.cfg && \
    echo '-CIARM' >> rpi3.cfg && \
    echo '-CaEABIHF' >> rpi3.cfg && \
    echo '-OoFASTMATH' >> rpi3.cfg && \
    echo '-Fu/root/ultibo/core/fpc/units/armv7-ultibo/rtl' >> rpi3.cfg && \
    echo '-Fu/root/ultibo/core/fpc/units/armv7-ultibo/packages' >> rpi3.cfg && \
    echo '-Fl/root/ultibo/core/fpc/units/armv7-ultibo/lib' >> rpi3.cfg && \
\
    touch qemuvpb.cfg  && \
    echo '#' >> qemuvpb.cfg && \
    echo '# QEMU arm7a specific config file' >> qemuvpb.cfg && \
    echo '#' >> qemuvpb.cfg && \
    echo '-CfVFPV3' >> qemuvpb.cfg && \
    echo '-CIARM' >> qemuvpb.cfg && \
    echo '-CaEABIHF' >> qemuvpb.cfg && \
    echo '-OoFASTMATH' >> qemuvpb.cfg && \
    echo '-Fu/root/ultibo/core/fpc/units/armv7-ultibo/rtl' >> qemuvpb.cfg && \
    echo '-Fu/root/ultibo/core/fpc/units/armv7-ultibo/packages' >> qemuvpb.cfg && \
    echo '-Fl/root/ultibo/core/fpc/units/armv7-ultibo/lib' >> qemuvpb.cfg
    head -20 *.cfg

# armv7a and armv6 rtl and packages

RUN make rtl_clean CROSSINSTALL=1 OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a BINUTILSPREFIX=arm-none-eabi- FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make rtl OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a BINUTILSPREFIX=arm-none-eabi- FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make rtl_install CROSSINSTALL=1 BINUTILSPREFIX=arm-none-eabi- FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH" OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a FPC=/root/ultibo/core/fpc/bin/fpc INSTALL_PREFIX=/root/ultibo/core/fpc INSTALL_UNITDIR=/root/ultibo/core/fpc/units/armv7-ultibo/rtl && \
\
    make rtl_clean CROSSINSTALL=1 OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a BINUTILSPREFIX=arm-none-eabi- FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make packages_clean CROSSINSTALL=1 OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a BINUTILSPREFIX=arm-none-eabi- FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make packages OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a BINUTILSPREFIX=arm-none-eabi- FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH -Fu/root/ultibo/core/fpc/units/armv7-ultibo/rtl" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make packages_install CROSSINSTALL=1 BINUTILSPREFIX=arm-none-eabi- FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH" OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a FPC=/root/ultibo/core/fpc/bin/fpc INSTALL_PREFIX=/root/ultibo/core/fpc INSTALL_UNITDIR=/root/ultibo/core/fpc/units/armv7-ultibo/packages && \
\
    make rtl_clean CROSSINSTALL=1 OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv6 BINUTILSPREFIX=arm-none-eabi- FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV6 -CfVFPV2 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make rtl OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv6 BINUTILSPREFIX=arm-none-eabi- FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV6 -CfVFPV2 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make rtl_install CROSSINSTALL=1 BINUTILSPREFIX=arm-none-eabi- FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV6 -CfVFPV2 -CIARM -CaEABIHF -OoFASTMATH" OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv6 FPC=/root/ultibo/core/fpc/bin/fpc INSTALL_PREFIX=/root/ultibo/core/fpc INSTALL_UNITDIR=/root/ultibo/core/fpc/units/armv6-ultibo/rtl && \
\
    make rtl_clean CROSSINSTALL=1 OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv6 BINUTILSPREFIX=arm-none-eabi- FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV6 -CfVFPV2 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make packages_clean CROSSINSTALL=1 OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv6 BINUTILSPREFIX=arm-none-eabi- FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV6 -CfVFPV2 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make packages OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv6 BINUTILSPREFIX=arm-none-eabi- FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV6 -CfVFPV2 -CIARM -CaEABIHF -OoFASTMATH -Fu/root/ultibo/core/fpc/units/armv6-ultibo/rtl" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make packages_install CROSSINSTALL=1 BINUTILSPREFIX=arm-none-eabi- FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV6 -CfVFPV2 -CIARM -CaEABIHF -OoFASTMATH" OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv6 FPC=/root/ultibo/core/fpc/bin/fpc INSTALL_PREFIX=/root/ultibo/core/fpc INSTALL_UNITDIR=/root/ultibo/core/fpc/units/armv6-ultibo/packages

WORKDIR /test
RUN apt-get update && apt-get install -y git
COPY build-examples.sh .
RUN ./build-examples.sh

WORKDIR /workdir
ENTRYPOINT ["fpc"]
CMD ["-i"]

RUN [ "cross-build-end" ]
