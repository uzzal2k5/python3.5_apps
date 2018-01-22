FROM ubuntu:16.04

MAINTAINER uzzal,< uzzal2k5@gmail.com >

# Install required packages and remove the apt packages cache when done.

RUN apt-get update && \
    apt-get install -y vim \
    openssl net-tools \
    libssl-dev \
    net-tools
RUN apt-get install -y cron
RUN apt-get install -y build-essential libssl-dev libffi-dev python3-dev
RUN apt-get install -y python3-pip
RUN apt-get install -y libmysqlclient-dev
# install uwsgi now because it takes a little while
RUN python3 -m pip install --upgrade pip
COPY req/requirements.txt /
RUN chmod a+x /requirements.txt
RUN pip3 install -r /requirements.txt
RUN pip3 install mysqlclient
#RUN pip3 install mysql-connector

RUN ln -sf /dev/stdout /var/log/apps/access.log \
	&& ln -sf /dev/stderr /var/log/apps/error.log
RUN mkdir /var/apps

RUN ln -sf /usr/bin/python3    /usr/bin/python
COPY cron/apps_cron /
RUN chmod +x /apps_cron
RUN sh /apps_cron

