FROM php:7.4-apache

RUN apt-get update && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev && docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install -j$(nproc) gd

RUN apt-get install -y wget

WORKDIR /var/www/html

RUN wget https://github.com/coppermine-gallery/cpg1.6.x/archive/v1.6.10.tar.gz
RUN tar -xf v1.6.10.tar.gz
RUN cp -r /var/www/html/cpg1.6.x-1.6.10 /var/www/html/coppermine
RUN chmod -R 755 /var/www/html/coppermine
RUN chmod -R 777 /var/www/html/coppermine/include
RUN chmod -R 777 /var/www/html/coppermine/albums
RUN rm cpg1.6.x-1.6.10 -d -r
RUN rm v1.6.10.tar.gz
RUN rm /etc/apache2/sites-enabled/*.conf

COPY coppermine.conf /etc/apache2/sites-available/coppermine.conf

RUN a2ensite coppermine

EXPOSE 80
