#!/bin/bash
set -e

echo "### Starting Overpass ###"

service apache2 start

cd /srv && nohup bin/dispatcher --osm-base --db-dir=/srv/db --meta &

echo "Testing over Monaco, you should get some result unless you've imported a different area"

curl 'http://localhost:80/api/interpreter?data=%5Btimeout%3A10%5D%5Bout%3Ajson%5D%3B(node(around%3A10%2C43.73991%2C7.42496)%3Bway(around%3A10%2C43.73991%2C7.42496))%3Bout+tags+geom(43.73760021380981%2C7.424295544624329%2C43.74103994517888%2C7.425419390201569)%3Brelation(around%3A10%2C43.73991%2C7.42496)%3Bout+geom(43.73760021380981%2C7.424295544624329%2C43.74103994517888%2C7.425419390201569)%3B'

echo "### Done starting up! ###"

echo "Tailing access.log"

tail -f /var/log/apache2/access.log




