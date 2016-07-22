FROM ubuntu:16.04
MAINTAINER slachiewicz@gmail.com
# http://wiki.openstreetmap.org/wiki/Overpass_API/Installation

RUN apt update && apt install -y g++ make expat libexpat1-dev zlib1g-dev
#build-essential autoconf automake  expat libtool libexpat1-dev zlib1g-dev apache2

RUN mkdir /app/build && cd /app/build && \
git clone -b test755 https://github.com/mmd-osm/Overpass-API.git && cd Overpass-API \
&& ./configure CXXFLAGS="-O3" --prefix=/app && make install -j 4

RUN cd /app/build && \
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

RUN wget $DOWNLOAD_URL -O /import.osm.bz2 && cd /srv/ && chown -R www-data:www-data * && cd /srv/ && bash bin/init_osm3s.sh /import.osm.bz2 /srv/db ./ --meta && chmod -R 755 /var/www/html && chown -R www-data:www-data /var/www/html && rm /import.osm.bz2

EXPOSE 80

RUN service apache2 stop

CMD ["/usr/src/app/start-overpass-api.sh"]
