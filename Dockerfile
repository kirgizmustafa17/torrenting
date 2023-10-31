FROM ubuntu:22.04

WORKDIR /app

ENV DEBIAN_FRONTEND="noninteractive"

RUN mkdir /root/.config/qBittorrent/; echo W0xlZ2FsTm90aWNlXQpBY2NlcHRlZD10cnVlCgpbUHJlZmVyZW5jZXNdCldlYlVJXEhvc3RIZWFkZXJWYWxpZGF0aW9uPWZhbHNlCkRvd25sb2Fkc1xTYXZlUGF0aD0vZG93bmxvYWRzLw== | base64 --decode > /root/.config/qBittorrent/qBittorrent.conf

RUN apt update && \
    apt upgrade -y && \
    # INSTALLATION qbittorrent-nox
    apt install -y wget libicu-dev dirmngr ca-certificates software-properties-common apt-transport-https screen gnupg && \
    add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable && \
    apt install -y qbittorrent-nox && \
    # INSTALLATION Jackett
    f=Jackett.Binaries.LinuxAMDx64.tar.gz && \
    release=$(wget -q https://github.com/Jackett/Jackett/releases/latest -O - | grep "title>Release" | cut -d " " -f 4) && \
    wget https://github.com/Jackett/Jackett/releases/download/$release/"$f" && \
    tar xf $f && \
    rm $f && \
    apt-get clean && \
#    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
#    echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
#    apt update && \
#    apt install -y mono-devel && \
    ./Jackett/jackett & && \
    qbittorrent-nox &
