FROM ubuntu:22.04

WORKDIR /app

ENV DEBIAN_FRONTEND="noninteractive"
ENV release="v0.21.1112"
ENV file="Jackett.Binaries.LinuxAMDx64.tar.gz"


RUN mkdir -p /root/.config/qBittorrent/
RUN echo W0xlZ2FsTm90aWNlXQpBY2NlcHRlZD10cnVlCgpbUHJlZmVyZW5jZXNdCldlYlVJXEhvc3RIZWFkZXJWYWxpZGF0aW9uPWZhbHNlCkRvd25sb2Fkc1xTYXZlUGF0aD0vZG93bmxvYWRzLw== | base64 --decode > /root/.config/qBittorrent/qBittorrent.conf

RUN apt update
RUN apt upgrade -y
RUN apt install -y wget libicu-dev dirmngr ca-certificates software-properties-common apt-transport-https screen gnupg
RUN add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable
RUN apt install -y qbittorrent-nox
#RUN f=Jackett.Binaries.LinuxAMDx64.tar.gz
# RUN release=$(wget -q https://github.com/Jackett/Jackett/releases/latest -O - | grep "title>Release" | cut -d " " -f 4)
RUN wget https://github.com/Jackett/Jackett/releases/download/$release/$file
RUN tar xf $file
RUN rm $file
RUN apt-get clean
RUN ./Jackett/jackett &
RUN qbittorrent-nox &
