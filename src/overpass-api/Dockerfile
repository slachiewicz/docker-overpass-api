FROM ubuntu:14.04
MAINTAINER thomas.kalka@gmail.com

RUN apt-get update && apt-get install -y \
  autoconf \ 
  automake1.11 \
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

RUN git clone https://github.com/drolbr/Overpass-API.git

RUN cd /Overpass-API/src && \
  autoscan && \
  aclocal-1.11 && \
  autoheader && \
  libtoolize && \
  automake-1.11 --add-missing && \
  autoconf && \
  cd /Overpass-API/build && \
  ../src/configure CXXFLAGS="-O3" --prefix=/srv && \
  make install -j 4 

RUN a2enmod cgi

RUN echo "<VirtualHost *:80>
	ExtFilterDefine gzip mode=output cmd=/bin/gzip
	ScriptAlias /api/ /srv/cgi-bin/
	<Directory "/srv/cgi-bin/">
AllowOverride None
Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
# For Apache 2.4:
  Order allow,deny
# For Apache > 2.4:  
#Require all granted
# SetOutputFilter gzip
# Header set Content-Encoding gzip
	</Directory>
ErrorLog /var/log/apache2/error.log
	CustomLog /var/log/apache2/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/000-default.conf

RUN service apache2 restart
