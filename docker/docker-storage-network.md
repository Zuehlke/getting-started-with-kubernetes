# Storage
[⬅️ Back to Docker overview](docker.md)

There are **volume mounts** and **bind mounts**. Bind mounts are created by binding an existing folder in the host system while volume mounts are managed by Docker. By default there is no persistence in your Docker container. 

In the example we will create our own **index.html** and use a bind mount into the container. 
```
cd /tmp
mkdir www
cd www
echo "hello world" > index.html

#New way
docker run -d -p 8003:80  --mount type=bind,source=/tmp/www,target=/usr/share/nginx/html nginx:latest

#Old way
docker run -d -p 8003:80 -v /tmp/www:/usr/share/nginx/html nginx:latest

# For Windows Users without WSL: Crete the index.html in C:\Temp. 
# Use a slash instead of a backslash to determine the host system path. 
docker run -d -p 8003:80 -v C:/Temp/:/usr/share/nginx/html nginx:latest
```
## Exercise
* 📝 Create your own **index.html**  and run it a volume mount in a Nginx container.
* 📝 Open the website in your browser and modify the **index.html**. Refresh afterwards to see the changes.
* 📝 Visit http://localhost:8003 to view your results.
  
Create a managed volume and inspect it
```
docker volume create my-vol
docker volume ls
docker volume inspect my-vol
```
Delete the volume
```
 docker volume rm my-vol 
 ```

Create a nginx container with managed volume via volume mount 
```
docker volume create my-vol2
# new way
docker run -d  -p 8003:80 --name devtest --mount source=myvol2,target=/usr/share/nginx/html nginx:latest
# Old way
docker run -d -p 8003:80 --name devtest -v myvol2:/usr/share/nginx/html nginx:latest
# Check the created volume
docker volume ls | grep myvol2
```
💡 Volumes will be created if they don't exist. 

# Network
There three modes bridge, none and host. Docker has by default one internal network and DNS (container name).

Show the networks and inspect the default network
```
docker network ls
docker network inspect bridge
# Grep for the subnet
docker network inspect bridge | grep Subnet
```
💡 The subnet of your default network is the IP range of your containers. 

Nginx for different subnets
```
# Nginx container with default setup
docker run -d --name ngnix_default nginx
# The following command prints out the specific line. A normal inspect like **docker inspect ngnix_default**  works as well.
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ngnix_default

# Nginx container with no network. 
docker run -d --name ngnix_nonetwork --network=none nginx
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ngnix_nonetwork 

# If you use the host network mode for a container, that container’s network stack is not isolated from the Docker host (the container shares the host’s networking namespace), and the container does not get its own IP-address allocated. 
docker run -d --name ngnix_host --network=host nginx
```

Create a new network with the name wp-mysql-network
```
docker network create --driver bridge --subnet 182.18.0.1/24 --gateway 182.18.0.1 wp-mysql-network
```
## Exercise
* 📝 Deploy a MySQL database using the mysql:5.6 image and name it mysql-db. Attach it to the newly created network wp-mysql-network
* 📝 Set the database password to use db_pass123. The environment variable to set is MYSQL_ROOT_PASSWORD.
* 📝 Inspect the container if it is attached to the created network.
* 📝 Remove all resources you have created during this session.
