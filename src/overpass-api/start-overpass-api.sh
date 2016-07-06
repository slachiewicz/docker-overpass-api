#!/bin/bash
set -e

echo "### Starting Overpass ###"

su - overpass_user -c "cd /home/overpass_user/ && bin/dispatcher --osm-base --db-dir=/home/overpass_user/overpass/db --meta &"

service apache2 restart

wget --output-document=test1.xml http://localhost

cat test1.xml

wget --output-document=test2.xml http://localhost/api/interpreter?data=%3Cprint%20mode=%22body%22/%3E

cat test2.xml

echo "### Done starting up! ###"

tail -f /var/log/apache2/error.log



