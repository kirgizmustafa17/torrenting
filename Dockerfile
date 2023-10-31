FROM ubuntu:22.04

WORKDIR /app

ENV DEBIAN_FRONTEND="noninteractive"

RUN mkdir /root/.config/qBittorrent/; echo W0xlZ2FsTm90aWNlXQpBY2NlcHRlZD10cnVlCgpbUHJlZmVyZW5jZXNdCldlYlVJXEhvc3RIZWFkZXJWYWxpZGF0aW9uPWZhbHNlCkRvd25sb2Fkc1xTYXZlUGF0aD0vZG93bmxvYWRzLw== | base64 --decode > /root/.config/qBittorrent/qBittorrent.conf

RUN \
    apt update && \
    apt upgrade -y && \
    apt install -y wget libicu-dev dirmngr ca-certificates software-properties-common apt-transport-https screen gnupg && \
    add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable && \
    apt install -y qbittorrent-nox && \
    f=Jackett.Binaries.LinuxAMDx64.tar.gz && \
    release=$(wget -q https://github.com/Jackett/Jackett/releases/latest -O - | grep "title>Release" | cut -d " " -f 4) && \
    wget https://github.com/Jackett/Jackett/releases/download/$release/"$f" && \
    tar xf $f && \
    rm $f && \
    apt-get clean && \
    ./Jackett/jackett & && \
    qbittorrent-nox &
