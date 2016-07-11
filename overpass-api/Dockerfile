FROM ubuntu:14.04
MAINTAINER thomas.kalka@gmail.com

RUN apt-get update && apt-get install -y \
  autoconf \ 
  automake1.11 \
  wget \
  curl \
  expat \
  g++ \
  libtool \
  libexpat1-dev \ 
  make \
  zlib1g-dev \
  apache2 \
  curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir /srv/build && cd /srv/build && \
wget http://dev.overpass-api.de/releases/osm-3s_v0.7.52.tar.gz && tar -zxvf osm-3s_v0.7.52.tar.gz && \
cd osm-3s_v0.7.52 && ./configure CXXFLAGS="-O3" --prefix=/srv && make install -j 4

RUN cd /srv/build && \
wget http://dev.overpass-api.de/releases/osm-3s_v0.7.52_html.tar.gz && \
tar -zxvf osm-3s_v0.7.52_html.tar.gz && \
cd osm-3s_v0.7.52/html && cp -R * /var/www/html/

RUN a2enmod cgi ext_filter
RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY / /usr/src/app

RUN cp /usr/src/app/000-default.conf /etc/apache2/sites-available/000-default.conf

ARG DOWNLOAD_URL="http://ftp5.gwdg.de/pub/misc/openstreetmap/planet.openstreetmap.org/planet/planet-latest.osm.bz2"
ENV DOWNLOAD_URL ${DOWNLOAD_URL}

RUN wget $DOWNLOAD_URL -O /import.osm.bz2

RUN cd /srv/ && chown -R www-data:www-data *

RUN cd /srv/ && bash bin/init_osm3s.sh /import.osm.bz2 /srv/db ./ --meta

RUN chmod -R 755 /var/www/html && chown -R www-data:www-data /var/www/html

RUN rm /import.osm.bz2

EXPOSE 80

RUN service apache2 stop

CMD ["/usr/src/app/start-overpass-api.sh"]
