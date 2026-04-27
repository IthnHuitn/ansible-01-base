FROM ubuntu:22.04

# Установка systemd
RUN apt-get update && apt-get install -y systemd systemd-sysv && apt-get clean

# Настройка systemd для работы в контейнере (опционально, но желательно)
RUN cd /lib/systemd/system/sysinit.target.wants/ && \
    ls | grep -v systemd-tmpfiles-setup | xargs rm -f && \
    rm -f /lib/systemd/system/multi-user.target.wants/* && \
    rm -f /etc/systemd/system/*.wants/* && \
    rm -f /lib/systemd/system/local-fs.target.wants/* && \
    rm -f /lib/systemd/system/sockets.target.wants/*udev* && \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl* && \
    rm -f /lib/systemd/system/basic.target.wants/*

STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]