FROM philcryer/min-jessie

RUN cd /root && \
    apt-get update && \
    apt-get install -y wget binutils unzip bzip2 gcc && \
    wget -q -O fpc_3.0.0-151205_amd64.deb 'http://downloads.sourceforge.net/project/lazarus/Lazarus%20Linux%20amd64%20DEB/Lazarus%201.6.2/fpc_3.0.0-151205_amd64.deb?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Flazarus%2Ffiles%2FLazarus%2520Linux%2520amd64%2520DEB%2FLazarus%25201.6.2%2F&ts=1483204950&use_mirror=superb-sea2' && \
    dpkg -i fpc_3.0.0-151205_amd64.deb && \
    rm fpc_3.0.0-151205_amd64.deb && \
    fpc -i

RUN cd /root && \
    wget -q https://github.com/ultibohub/FPC/archive/master.zip && \
    mkdir -p ultibo/core && \
    cd ultibo/core && \
    unzip -q ../../master.zip && \
    rm ../../master.zip && \
    mv FPC-master fpc && \
    wget -q https://github.com/ultibohub/Core/archive/master.zip && \
    unzip -q master.zip && \
    rm master.zip && \
    mkdir -p /root/ultibo/core/fpc/source/packages && \
    mv Core-master/source/rtl/ultibo /root/ultibo/core/fpc/source/rtl && \
    mv Core-master/source/packages/ultibounits /root/ultibo/core/fpc/source/packages && \
    mv Core-master/units /root/ultibo/core/fpc && \
    cd /root/ultibo/core/fpc/source && \
    apt-get install -y make libc-dev libc6-i386 && \
    make distclean && \
    make all OS_TARGET=linux CPU_TARGET=x86_64 && \
    make install OS_TARGET=linux CPU_TARGET=x86_64 INSTALL_PREFIX=/root/ultibo/core/fpc && \
    cp /root/ultibo/core/fpc/source/compiler/ppcx64 /root/ultibo/core/fpc/bin/ppcx64 && \
    /root/ultibo/core/fpc/bin/fpc -i && \
    /root/ultibo/core/fpc/bin/fpcmkcfg -d basepath=/root/ultibo/core/fpc/lib/fpc/3.1.1 -o /root/ultibo/core/fpc/bin/fpc.cfg

RUN cd /root && \
    wget -q https://launchpadlibrarian.net/287101520/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2 && \
    bunzip2 gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2 && \
    tar xf gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar && \
    rm gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar && \
\
    cp /root/gcc-arm-none-eabi-5_4-2016q3/arm-none-eabi/bin/as /root/ultibo/core/fpc/bin/arm-ultibo-as && \
    cp /root/gcc-arm-none-eabi-5_4-2016q3/arm-none-eabi/bin/ld /root/ultibo/core/fpc/bin/arm-ultibo-ld && \
    cp /root/gcc-arm-none-eabi-5_4-2016q3/arm-none-eabi/bin/objcopy /root/ultibo/core/fpc/bin/arm-ultibo-objcopy && \
    cp /root/gcc-arm-none-eabi-5_4-2016q3/arm-none-eabi/bin/objdump /root/ultibo/core/fpc/bin/arm-ultibo-objdump && \
    cp /root/gcc-arm-none-eabi-5_4-2016q3/arm-none-eabi/bin/strip /root/ultibo/core/fpc/bin/arm-ultibo-strip && \
\
    cd /root/ultibo/core/fpc/source && \
    export PATH=/root/ultibo/core/fpc/bin:$PATH && \
    make distclean OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a BINUTILSPREFIX=arm-ultibo- FPCOPT="-dFPC_ARMHF" CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/ppcx64 && \
    make all OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a BINUTILSPREFIX=arm-ultibo- FPCOPT="-dFPC_ARMHF" CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/ppcx64 && \
    make crossinstall BINUTILSPREFIX=arm-ultibo- FPCOPT="-dFPC_ARMHF" CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH" OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a FPC=/root/ultibo/core/fpc/bin/ppcx64 INSTALL_PREFIX=/root/ultibo/core/fpc && \
\
    cp /root/ultibo/core/fpc/source/compiler/ppcrossarm /root/ultibo/core/fpc/bin/ppcrossarm && \
\
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
    head -20 *.cfg && \
\
    touch fpcrpi && \
    echo '#!/bin/bash' >> fpcrpi && \
    echo 'export PATH=/root/ultibo/core/fpc/bin:$PATH' >> fpcrpi && \
    echo 'fpc -B -Tultibo -Parm -CpARMV7A -WpRPIB @/root/ultibo/core/fpc/bin/rpi.cfg -O2 $*' >> fpcrpi && \
    chmod u+x fpcrpi && \
\
    touch fpcrpi2 && \
    echo '#!/bin/bash' >> fpcrpi2 && \
    echo 'export PATH=/root/ultibo/core/fpc/bin:$PATH' >> fpcrpi2 && \
    echo 'fpc -B -Tultibo -Parm -CpARMV7A -WpRPI2B @/root/ultibo/core/fpc/bin/rpi2.cfg -O2 $*' >> fpcrpi2 && \
    chmod u+x fpcrpi2 && \
\
    touch fpcrpi3 && \
    echo '#!/bin/bash' >> fpcrpi3 && \
    echo 'export PATH=/root/ultibo/core/fpc/bin:$PATH' >> fpcrpi3 && \
    echo 'fpc -B -Tultibo -Parm -CpARMV7A -WpRPI3B @/root/ultibo/core/fpc/bin/rpi3.cfg -O2 $*' >> fpcrpi3 && \
    chmod u+x fpcrpi3 && \
\
    head fpcrpi*

# armv7a and armv6 rtl and packages

RUN cd /root/ultibo/core/fpc/source && \
    export PATH=/root/ultibo/core/fpc/bin:$PATH && \
    make rtl_clean CROSSINSTALL=1 OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make rtl OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make rtl_install CROSSINSTALL=1 FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH" OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a FPC=/root/ultibo/core/fpc/bin/fpc INSTALL_PREFIX=/root/ultibo/core/fpc INSTALL_UNITDIR=/root/ultibo/core/fpc/units/armv7-ultibo/rtl && \
\
    export PATH=/root/ultibo/core/fpc/bin:$PATH && \
    make rtl_clean CROSSINSTALL=1 OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make packages_clean CROSSINSTALL=1 OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make packages OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH -Fu/root/ultibo/core/fpc/units/armv7-ultibo/rtl" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make packages_install CROSSINSTALL=1 FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV7A -CfVFPV3 -CIARM -CaEABIHF -OoFASTMATH" OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv7a FPC=/root/ultibo/core/fpc/bin/fpc INSTALL_PREFIX=/root/ultibo/core/fpc INSTALL_UNITDIR=/root/ultibo/core/fpc/units/armv7-ultibo/packages && \
\
    make rtl_clean CROSSINSTALL=1 OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv6 FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV6 -CfVFPV2 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make rtl OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv6 FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV6 -CfVFPV2 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make rtl_install CROSSINSTALL=1 FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV6 -CfVFPV2 -CIARM -CaEABIHF -OoFASTMATH" OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv6 FPC=/root/ultibo/core/fpc/bin/fpc INSTALL_PREFIX=/root/ultibo/core/fpc INSTALL_UNITDIR=/root/ultibo/core/fpc/units/armv6-ultibo/rtl && \
\
    export PATH=/root/ultibo/core/fpc/bin:$PATH && \
    make rtl_clean CROSSINSTALL=1 OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv6 FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV6 -CfVFPV2 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make packages_clean CROSSINSTALL=1 OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv6 FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV6 -CfVFPV2 -CIARM -CaEABIHF -OoFASTMATH" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make packages OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv6 FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV6 -CfVFPV2 -CIARM -CaEABIHF -OoFASTMATH -Fu/root/ultibo/core/fpc/units/armv6-ultibo/rtl" FPC=/root/ultibo/core/fpc/bin/fpc && \
    make packages_install CROSSINSTALL=1 FPCFPMAKE=/root/ultibo/core/fpc/bin/fpc CROSSOPT="-CpARMV6 -CfVFPV2 -CIARM -CaEABIHF -OoFASTMATH" OS_TARGET=ultibo CPU_TARGET=arm SUBARCH=armv6 FPC=/root/ultibo/core/fpc/bin/fpc INSTALL_PREFIX=/root/ultibo/core/fpc INSTALL_UNITDIR=/root/ultibo/core/fpc/units/armv6-ultibo/packages
