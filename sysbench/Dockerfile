FROM centos:latest
MAINTAINER Ben Mildren

RUN yum install -y http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm && \
    yum update && \
    sed -i 's/tsflags=nodocs//g' /etc/yum.conf && \
    yum install -y sysbench nmap && \
    yum clean all && \
    rm -rf /var/cache/yum

COPY ./scripts/run/run.sh /scripts/run.sh 

ENV MYSQL_HOST=db1_mysql MYSQL_USER=sysbench MYSQL_PASSWORD=sysbench MYSQL_DB=sbtest

CMD [ "/scripts/run.sh" ]
