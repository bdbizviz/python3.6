FROM python:3.6-alpine3.8

RUN pip install --upgrade pip
RUN apk add --no-cache bzip2-dev coreutils dpkg-dev dpkg expat-dev \
		findutils gcc gdbm-dev libc-dev libffi-dev libnsl-dev libressl \
		libressl-dev libtirpc-dev linux-headers make ncurses-dev pax-utils \
		readline-dev sqlite-dev tcl-dev tk tk-dev xz-dev zlib-dev 

RUN pip install django==1.10
RUN pip install djangorestframework
RUN pip install channels==1.1.8
RUN pip install asgi_rabbitmq==0.5.4
RUN pip install celery==4.1.1
RUN pip install pyspark==2.2.1
			
RUN apk add python3-tkinter python3-dev

RUN pip install numpy==1.13.1

# need 2 packages && wget http://www.netlib.org/blas/blas-3.6.0.tgz and  wget http://www.netlib.org/lapack/lapack-3.6.1.tgz 
RUN apk add lapack openblas-dev ca-certificates libstdc++ libgfortran 
RUN apk add --virtual=build_dependencies gfortran g++ make cython
RUN pip install scipy==0.19.1
RUN pip install scikit-learn==0.19.0
RUN pip install Cython
RUN ln -s /usr/include/locale.h /usr/include/xlocale.h
RUN pip install pandas==0.21.0
RUN pip install matplotlib==2.0.2
RUN pip install bokeh==0.12.13

# Follow this link -> https://bokeh.pydata.org/en/latest/docs/dev_guide/setup.html#node-packages
RUN pip install npm
RUN pip install nodejs
RUN pip install schema==0.6.6
RUN pip install elasticsearch==2.3.0
RUN pip install termcolor	

#RUN pip install mysql-connector==2.0.4
RUN wget https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-2.0.5.tar.gz
RUN pip install mysql-connector-python-2.0.5.tar.gz
RUN rm -f mysql-connector-python-2.0.5.tar.gz 

RUN apk add freetds-dev
RUN apk add py3-setuptools
#In order to solve this issue by using pymssql 2.1.3, I have
#modified header of /usr/include/sybdb.h belonging to the libsybdb-devel
#package (Cygwin) by adding line below:
#define DBVERSION_80 DBVERSION_71
COPY sybdb.h /usr/include/sybdb.h
RUN pip install pymssql==2.1.3

RUN pip install cx_Oracle==6.0.2
RUN mkdir -p /opt/oracle
RUN cd /opt/oracle
COPY instantclient-basic-linux.x64-12.2.0.1.0.zip ./
RUN unzip instantclient-basic-linux.x64-12.2.0.1.0.zip
RUN apk add libaio 
ENV LD_LIBRARY_PATH /opt/oracle/instantclient_12_2
RUN rm -rf instantclient-basic-linux.x64-12.2.0.1.0.zip

#RUN apk add openssl-dev
RUN pip install paramiko==2.4.0

CMD exec /bin/sh -c "trap : TERM INT; (while true; do sleep 1000; done) & wait "



