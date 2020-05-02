A Docker container with very basic provisioning of Ubuntu + nginx + MERN (MongoDb, Express.js, React, Node.js)

# Usage
## OSX / Ubuntu:
`docker run -it --rm --name lemp -p 80:80 --mount type=bind,source=$(PWD),target=/var/www/html/ kmrd/mern`

## Windows:
`docker run -it --rm --name lemp -p 80:80 --mount type=bind,source="%cd%",target=/var/www/html/ kmrd/mern`
