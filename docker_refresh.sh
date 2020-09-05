docker stop informix
docker rm informix
docker ps -a -q | xargs -n 1 -I {} docker rm {}
docker rmi $( docker images | grep '<none>' | tr -s ' ' | cut -d ' ' -f 3)
docker volume rm $(docker volume ls -qf dangling=true)
cd ./server_ctx
docker build -t loopback/informix .
# docker run  -d -h informix --name informix loopback/informix --start
# docker exec -it informix bash

