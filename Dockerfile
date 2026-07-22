FROM php:8.1-apache

# Install PHP extensions required by Coppermine
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libwebp-dev \
    libfreetype6-dev \
    libzip-dev \
    libexif-dev \
    imagemagick \
    libmagickwand-dev \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Configure and install GD with JPEG, PNG, WebP, FreeType support
RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    --with-webp

RUN docker-php-ext-install -j$(nproc) \
    gd \
    mysqli \
    exif \
    zip \
    gettext

# Install ImageMagick PHP extension
RUN pecl install imagick && docker-php-ext-enable imagick

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set document root permissions
RUN chown -R www-data:www-data /var/www/html

# PHP config: increase limits for photo uploads
RUN echo "upload_max_filesize = 32M" >> /usr/local/etc/php/conf.d/coppermine.ini \
    && echo "post_max_size = 64M" >> /usr/local/etc/php/conf.d/coppermine.ini \
    && echo "memory_limit = 256M" >> /usr/local/etc/php/conf.d/coppermine.ini \
    && echo "max_execution_time = 120" >> /usr/local/etc/php/conf.d/coppermine.ini

# Allow .htaccess overrides
RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

EXPOSE 80
