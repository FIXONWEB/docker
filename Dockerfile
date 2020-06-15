FROM php:7.2-apache

RUN apt-get update && apt-get install -y \
      libfreetype6-dev \
      libjpeg62-turbo-dev \
      libpng-dev \
      libmcrypt-dev \
      libgd-dev
#      git \
#      zip \
#      unzip \
#      nodejs \
#      wget \
#      vim \
#      && rm -rf /var/lib/apt/lists

RUN docker-php-ext-install pdo_mysql mysqli
RUN docker-php-ext-install mbstring
#RUN docker-php-ext-install zip
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

COPY ./apache/default.conf /etc/apache2/sites-available/000-default.conf

#COPY /Volumes/Data/htdocs/ /var/www/html/

WORKDIR /Volumes/Data/htdocs/

RUN a2enmod rewrite \
  && service apache2 restart

EXPOSE 80
