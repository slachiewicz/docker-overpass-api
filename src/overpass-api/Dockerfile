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

RUN wget http://dev.overpass-api.de/releases/osm-3s_v0.7.52.tar.gz && \
tar -zxvf osm-3s_v0.7.52.tar.gz && \
cd osm-3s_v0.7.52 && \
./configure CXXFLAGS="-O3" --prefix=/srv && \
make install

RUN a2enmod cgi ext_filter
RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY / /usr/src/app

RUN cp /usr/src/app/000-default.conf /etc/apache2/sites-available/000-default.conf

COPY import/*.osm.bz2 /import.osm.bz2

RUN cd /srv/ && bin/init_osm3s.sh /import.osm.bz2 /srv/db ./ --meta && chmod +x /srv/bin/dispatcher

RUN useradd -ms /bin/bash overpass_user

RUN chmod -R 755 /srv && \
chown -R overpass_user:overpass_user /srv && \
chown -R www-data:www-data /srv/cgi-bin && \
chmod -R 755 /var/www/html && \
chown -R www-data:www-data /var/www/html

RUN service apache2 restart

EXPOSE 80

CMD ["/usr/src/app/start-overpass-api.sh"]
