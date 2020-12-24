### Informix - Online Schema Upgrades using Loopback Replication

Take a look at the pdf file for presentation slides.
Demo scripts are in `server_ctx/`
This demo is based on Docker. You need to download and copy
`iif.14.10.fc3.tar` file into `server_ctx/` and run `docker_refresh.sh` script
to create docker image for informix and start informix container.

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/sCr8QRpKB_c/0.jpg)](https://www.youtube.com/watch?v=sCr8QRpKB_c)


```bash
# make sure ids image exist
ls -l loopback-replication/server_ctx/iif.14.10.fc3.tar
```

### login to your container registry
```bash
# you may need 'container login' for example 
docker login
# WARNING! Your password will be stored unencrypted in ~/.docker/config.json.
# docker logout

docker images

# incase if you have to clean the existing images
docker system prune
docker system prune -a
```

### docker build
```bash
# start the build
cd loopback-replication
./docker_refresh.sh

# If above build is success then check the image
docker images
# REPOSITORY          TAG       IMAGE ID       CREATED          SIZE
# loopback/informix   latest    d29abe509358   39 minutes ago   1.7GB
# centos              7         8652b9f0cb4c   5 weeks ago      204MB
```


### Run
```bash
# Show both running and stopped containers
docker ps -a
# CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES


# run the docker by assigning a container name = myids1
docker run -it -d --name myids1 loopback/informix
# e7bf4d895af5cf7c41b4e1021c5112b80844b8682960c60e79a48b0f876474d2

docker ps -a
# CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS         PORTS       NAMES
# e7bf4d895af5   loopback/informix   "/opt/ibm/boot.sh --…"   7 seconds ago   Up 6 seconds   60000/tcp   myids1

# runs a new command in a running container.
docker exec -it myids1 /bin/bash
# [root@e7bf4d895af5 ibm]

# we are inside the container now
onstat -
# IBM Informix Dynamic Server Version 14.10.FC3DE -- On-Line -- Up 00:04:01 -- 172660 Kbytes

# exit from the container
exit
```


### stop the container
```bash
docker ps -a
# CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS         PORTS       NAMES
# e7bf4d895af5   loopback/informix   "/opt/ibm/boot.sh --…"   7 minutes ago   Up 7 minutes   60000/tcp   myids1

# stop the container
docker stop myids1
# myids1

docker ps -a
# CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS                       PORTS     NAMES
# e7bf4d895af5   loopback/informix   "/opt/ibm/boot.sh --…"   7 minutes ago   Exited (137) 3 seconds ago             myids1
```


### delete the container
```bash
docker container rm myids1
# myids1

docker ps -a
# CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

### Cleanup
```bash
# incase if you have to clean the existing images
docker system prune
docker system prune -a

# logout from container registry
docker logout
```

