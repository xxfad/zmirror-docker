FROM ubuntu:16.04

ADD sources.list /etc/apt/

ENV LC_ALL C.UTF-8 

RUN apt-get update \
    && apt-get -y -q upgrade \
    && apt-get -y -q dist-upgrade \
    && apt-get -y -q install build-essential patch binutils make devscripts nano libtool libssl-dev libxml2 libxml2-dev software-properties-common python-software-properties dnsutils git wget curl python3 python3-pip iftop \
    && python3 -m pip install -U flask requests cchardet fastcache \
    && add-apt-repository -y ppa:ondrej/apache2 \
    && apt-key update \
    && apt-get update \
    && apt-get -y -q upgrade\
    && apt-get -y -q install apache2 \
    && a2enmod rewrite mime include headers filter expires deflate autoindex setenvif ssl http2 \
    && apt-get -y -q install libapache2-mod-wsgi-py3  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
