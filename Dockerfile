FROM ubuntu:16.04

#Set env var to install mysql-server whithout asking for user input
ENV DEBIAN_FRONTEND noninteractive

#Install Apache and other necessary packages
RUN apt-get update \
    && apt-get install apt-utils git mysql-server -y \
    && apt-get install -y apache2 php libapache2-mod-php \
    php-mysql php-curl php-xml php-memcached

WORKDIR /var

RUN chown -R $(whoami):$(whoami) www

WORKDIR /var/www/html

#Clone source code
COPY ./src .

#RUN service mysql start

RUN touch bootstrap.sql && \
     echo "CREATE DATABASE simple_lamp;" >> bootstrap.sql && \
     echo "CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';" >> bootstrap.sql && \
     echo "GRANT ALL PRIVILEGES ON simple_lamp.* TO 'username'@'localhost';" >> bootstrap.sql && \
     echo "FLUSH PRIVILEGES;" >> bootstrap.sql && \
     /etc/init.d/mysql start && \
     mysql < bootstrap.sql

RUN chown -R www-data:www-data uploads

RUN service mysql start && mysql -u username -ppassword simple_lamp < simple_lamp.sql

EXPOSE 80

COPY  startservices.sh startservices.sh

RUN rm index.html
RUN chmod +x startservices.sh

# Set the script as the entry point
ENTRYPOINT ["/var/www/html/startservices.sh"]
