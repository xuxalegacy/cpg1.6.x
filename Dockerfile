FROM php:7.4-apache

# Instala dependências e extensões do PHP
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    imagemagick \
    libmagickwand-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli exif zip

# Define o diretório de trabalho
WORKDIR /var/www/html

# Baixa e extrai o Coppermine
RUN wget -O coppermine.tar.gz https://github.com/coppermine-gallery/cpg1.6.x/archive/v1.6.10.tar.gz \
    && tar -xzf coppermine.tar.gz \
    && mv cpg1.6.x-1.6.10/* . \
    && rm -rf cpg1.6.x-1.6.10 \
    && rm coppermine.tar.gz

# Ajusta permissões
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expõe a porta 80
EXPOSE 80

# Inicia o Apache
CMD ["apache2-foreground"]
