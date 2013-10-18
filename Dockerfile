FROM ubuntu:precise
MAINTAINER Lewis Zhang "lewiszhang@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y curl language-pack-en
RUN locale-gen en_US
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update
RUN apt-get install -y postgresql-9.3 postgresql-contrib-9.3
ADD ./etc /etc
ADD ./bin /bin
RUN chown -R postgres:postgres /etc/postgresql
RUN /bin/docker-postgres-init-devdb
RUN service postgresql stop

EXPOSE 5432
USER postgres
ENTRYPOINT ["pg_ctl", "-D", "/var/lib/postgres"]
CMD ["start"]
