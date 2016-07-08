# docker-overpass-api

This is a containerized overpass API!

All you need to do is put the desired osm.bz2 in srv/overpass-api/import and then run:

docker-compose build overpass-api; docker-compose up -d overpass-api; docker ps -a (to get the port number)

This way, it can be deployed anywhere, and you're able to load balance across multiple instances

