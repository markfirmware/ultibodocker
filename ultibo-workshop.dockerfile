FROM debian:stretch

RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get -y install \
        sudo \
        qemu-system-arm \
        gdb-minimal  \
        libgtk2.0-dev  \
        libghc-x11-dev \
        binutils-arm-none-eabi \
        \
        unzip \
        wget

RUN useradd -m -u 1145 ultibo && \
    echo "ultibo ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/ultibo && \
    chmod 0440 /etc/sudoers.d/ultibo

USER ultibo
WORKDIR /home/ultibo

COPY ultiboinstaller-docker.sh .
RUN ./ultiboinstaller-docker.sh
RUN echo "export PATH=$PATH:/home/ultibo/ultibo/core/fpc/bin" >> ~/.bashrc
