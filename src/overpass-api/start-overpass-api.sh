#!/bin/bash
set -e

su - overpass_user -c "cd /srv && bin/dispatcher --osm-base --db-dir=/srv/db --meta &"

service apache2 start

wget --output-document=test1.xml http://localhost:80

cat test1.xml

#wget --output-document=test2.xml http://localhost:80/api/interpreter?data=%3Cprint%20mode=%22body%22/%3E

#cat test2.xml

sleep 100000



