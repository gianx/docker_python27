# Python2 with Oracle support image
#
# VERSION               0.0.1

FROM      ubuntu
MAINTAINER Gianluca Nieri <gianluca@gianlucanieri.com>

# Install packages
RUN apt-get -y update
RUN apt-get install -y libaio1 libaio-dev python-pip alien python-lxml python-psycopg2 python-dev poppler-utils

# Get, convert and install Oracle Client from an alternate location to avoid login
RUN curl -O http://repo.dlt.psu.edu/RHEL5Workstation/x86_64/RPMS/oracle-instantclient12.1-basic-12.1.0.1.0-1.x86_64.rpm
RUN curl -O http://repo.dlt.psu.edu/RHEL5Workstation/x86_64/RPMS/oracle-instantclient12.1-devel-12.1.0.1.0-1.x86_64.rpm
RUN alien -d *.rpm
RUN dpkg -i *.deb

# Setup Oracle environment variables
RUN echo "/usr/lib/oracle/12.1/client64/lib" > /etc/ld.so.conf.d/oracle.conf
ENV ORACLE_HOME /usr/lib/oracle/12.1/client64
ENV LD_LIBRARY_PATH /usr/lib/oracle/12.1/client64/lib
RUN ldconfig

# Install Python Packages
RUN pip install requests cx_oracle sqlalchemy flask tweepy

VOLUME ["/data"]
WORKDIR /data
EXPOSE 5000 5555 
