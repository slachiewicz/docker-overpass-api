FROM ubuntu:14.04
MAINTAINER thomas.kalka@gmail.com

RUN apt-get update && apt-get install -y \
  autoconf \ 
  automake1.11 \
  wget \
  expat \
  git \
  g++ \
  libtool \
  libexpat1-dev \ 
  make \
  zlib1g-dev \
  apache2 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash overpass_user

RUN su - overpass_user -c 'mkdir /home/overpass_user/Download && cd /home/overpass_user/Download && \
wget http://dev.overpass-api.de/releases/osm-3s_v0.7.52.tar.gz && \
tar -zxvf osm-3s_v0.7.52.tar.gz && \
cd osm-3s_v0.7.52 && mkdir /home/overpass_user/overpass && \
./configure CXXFLAGS="-O3" --prefix=/home/overpass_user/overpass && make install -j4'

RUN a2enmod cgi ext_filter
RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY / /usr/src/app

RUN cp /usr/src/app/000-default.conf /etc/apache2/sites-available/000-default.conf

COPY import/*.osm.bz2 /import.osm.bz2

RUN su - overpass_user -c 'cd /home/overpass_user/overpass && bash bin/init_osm3s.sh /import.osm.bz2 /home/overpass_user/overpass/db ./ --meta'

RUN chmod -R 755 /var/www/html && \
chown -R www-data:www-data /var/www/html

RUN service apache2 restart

EXPOSE 80

CMD ["/usr/src/app/start-overpass-api.sh"]
