# Favio's Mom API Docker 
#
# The following command is used if you want to use a Dockerized local container for the mysql database
#
# docker run --detach --name=docker_mysql --env="MYSQL_ROOT_PASSWORD=Yankees5a" --volume=/Users/jmiyares/development/docker/mysql-datadir:/var/lib/mysql  --publish 3306:3306 mysql
#
# 1 way of running the container.
# docker run -it -p 8000:8000  -e "NODE_ENV=docker" --link docker_mysql:mysql julio/faviosmom_api  node app.js
#
# the following assumes a mounted volume to write log files to
# docker run -it -p 8000:8000  -e "NODE_ENV=docker" --link docker_mysql:mysql   --volume=/Users/jmiyares/development/docker/logs-dir:/usr/logs julio/faviosmom_api node app.js
#
FROM node:8.2
MAINTAINER Julio Hernandez-Miyares julio@faviosmom.com

ENV USER node
ENV GROUP node
ENV APPLICATION_DIRECTORY /usr/src/app

# Create app directory
WORKDIR $APPLICATION_DIRECTORY

# Install app dependencies
COPY package.json .
RUN npm install

# Bundle app source
COPY . .

RUN chown -R $USER:$GROUP $APPLICATION_DIRECTORY

USER node
EXPOSE 8000 8080
CMD [ "node", "app.js" ]
