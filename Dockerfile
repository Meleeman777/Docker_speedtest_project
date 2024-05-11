FROM php:7.2-apache
WORKDIR /speedtest
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        apache2 \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && apt purge -y --auto-remove
COPY . . 
COPY docker/*.php /speedtest/
CMD ["bash", "/speedtest/docker/entrypoint.sh"]

