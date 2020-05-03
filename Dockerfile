#
# Ubunut-based PHP MERN stack
#
#
# Building:
# docker build -t kmrd/mern .
#
#
# Usage:
# ------------------
# OSX / Ubuntu:
# docker run -it --rm --name mern -p 80:80 --mount type=bind,source=$(PWD),target=/var/www/html/ kmrd/mern
#
# Windows:
# docker run -it --rm --name mern -p 80:80 --mount type=bind,source="%cd%",target=/var/www/html/ kmrd/mern
#
#
FROM ubuntu:20.04
MAINTAINER David Reyes <david@thoughtbubble.ca>

# Environments vars
ENV TERM=xterm
ENV DEBIAN_FRONTEND noninteractive 


#-----------------------#
# Installs              #
#-----------------------#

RUN apt-get -y update && \
    apt-get -y upgrade


RUN apt-get -y --fix-missing install \
 	  lsb-release \
      curl \
      apt-transport-https \
      git \
      nano \
      sudo \
      lsof \
      dos2unix \
      unzip \
      nodejs \
      npm


# Install supervisor (not strictly necessary)
RUN apt-get -y --fix-missing install supervisor && \
      mkdir -p /var/log/supervisor


# Install nginx (full)
RUN apt-get install -y nginx-full

# Install MySQL
RUN apt-get -y --fix-missing install \
      mysql-server \
      mysql-client \
      php-mysql

# Install LESS package
RUN npm install -g less


#-----------------------#
# Configurations        #
#-----------------------#
# Configure nginx default site
ADD conf/default /etc/nginx/sites-available/default

# RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Setting Permissions
RUN chown -R www-data:www-data /var/www/html

VOLUME /var/www/html

WORKDIR /var/www/html

EXPOSE 80
EXPOSE 443
EXPOSE 3000

#-----------------------#
# Final Action          #
#-----------------------#
# Use entrypoint script
ADD conf/entrypoint.sh /entrypoint.sh
RUN dos2unix /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

#Start nginx
# RUN nginx
# CMD ["nginx", "-g", "daemon off"]

#Start supervisor
# CMD ["/usr/bin/supervisord"]


#CMD ["/bin/bash"]


#CMD ["nginx"]

# CMD ["nginx", "-g", "daemon off"]
