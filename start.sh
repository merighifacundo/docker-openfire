docker build . -t openfirecustom
docker run --name openfire -d --restart=always --publish 9090:9090 --publish 5222:5222 --publish 7777:7777 --volume /srv/docker/openfire:/Users/facundomerighi/openfirex  -t openfirecustom
