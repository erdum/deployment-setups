# Base Image
FROM php:8.3-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
  nginx \
  libpng-dev \
  libjpeg-dev \
  libfreetype6-dev \
  zip \
  unzip \
  curl \
  git \
  supervisor \
  sqlite3 \
  libzip-dev \
  libxml2-dev \
  libonig-dev \
  libprotobuf-dev \
  protobuf-compiler \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install gd pdo_mysql zip xml mbstring bcmath

# Install php-redis
RUN pecl install redis && docker-php-ext-enable redis

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install gRPC silently
RUN pecl install grpc > /dev/null 2>&1 && echo "extension=grpc.so" > /usr/local/etc/php/conf.d/grpc.ini

# Copy Nginx configuration
COPY .docker/nginx.conf /etc/nginx/nginx.conf
COPY .docker/default.conf /etc/nginx/sites-available/default

# Copy the application files to the container
COPY . /var/www/html/

# Expose port 80
EXPOSE 80

# Start services
CMD service nginx start && php-fpm
