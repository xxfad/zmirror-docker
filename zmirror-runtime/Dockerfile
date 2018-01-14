FROM ubuntu:16.04

ADD sources.list /etc/apt/

ENV LC_ALL C.UTF-8 

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y dist-upgrade \
    && apt-get -y install build-essential patch binutils make devscripts nano libtool libssl-dev libxml2 libxml2-dev software-properties-common python-software-properties dnsutils git wget curl python3 python3-pip iftop

# 'requests==2.11'以下 才能播放youtube视频
RUN python3 -m pip install -U flask requests==2.11 cchardet fastcache -i https://pypi.tuna.tsinghua.edu.cn/simple \
    && add-apt-repository -y ppa:ondrej/apache2 \
    && apt-key update \
    && apt-get update \
    && apt-get -y upgrade\
    && apt-get -y install apache2 \
    && a2enmod rewrite mime include headers filter expires deflate autoindex setenvif ssl http2 \
    && apt-get -y install libapache2-mod-wsgi-py3  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
