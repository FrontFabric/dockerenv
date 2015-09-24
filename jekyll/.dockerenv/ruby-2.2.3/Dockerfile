FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get install build-essential libssl-dev -y
RUN apt-get install wget -y

RUN cd /tmp \
&& wget https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz \
&& tar -xzvf ruby-2.2.3.tar.gz \
&& cd ruby-2.2.3 \
&& ./configure --prefix=/usr/local \
&& make \
&& make install
