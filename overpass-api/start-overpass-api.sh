#!/bin/bash
set -e

echo "### Starting Overpass ###"

service apache2 start

cd /srv && nohup bin/dispatcher --osm-base --db-dir=/srv/db --meta &

echo "### Done starting up! ###"

echo "Tailing access.log"

tail -f /var/log/apache2/access.log




