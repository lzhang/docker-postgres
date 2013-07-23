FROM   ubuntu:precise
MAINTAINER   Ted Dziuba "tjdziuba@neomailbox.net"

RUN apt-get update
RUN apt-get install -y wget language-pack-en
RUN locale-gen en_US

ADD config /

RUN apt-key add /tmp/pgdg-apt-key.asc
RUN apt-get update
RUN apt-get install -y pgdg-keyring postgresql-9.2 postgresql-contrib-9.2 pwgen emacs23-nox

ADD config-stage2 /

EXPOSE 5432