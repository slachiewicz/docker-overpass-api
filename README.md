# docker-overpass-api

This is a containerized overpass API!

All you need to do is run:

 docker build --build-arg DOWNLOAD_URL=http://download.geofabrik.de/north-america/greenland-latest.osm.bz2 .

to build the image. If you do not specifiy a DOWNLOAD_URL, it will download the planet.osm.bz2 by default

This way, it can be deployed anywhere, and you're able to load balance across multiple instances

