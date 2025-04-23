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
  imagemagick \
  libmagickwand-dev \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install gd pdo_mysql zip xml mbstring bcmath

# Install php-redis
RUN pecl install redis && docker-php-ext-enable redis

# Install php-imagick
RUN pecl install imagick && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/imagick.ini

# Install gRPC (add cache validation)
RUN if ! pecl list | grep grpc; then pecl install grpc > /dev/null 2>&1; fi \
  && echo "extension=grpc.so" > /usr/local/etc/php/conf.d/grpc.ini

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set PHP upload limits
RUN echo "upload_max_filesize = 100M\npost_max_size = 100M" > /usr/local/etc/php/conf.d/uploads.ini

# Copy Nginx configuration
COPY .docker/nginx.conf /etc/nginx/nginx.conf
COPY .docker/default.conf /etc/nginx/sites-available/default

# Copy the Supervisor configuration for queue workers
COPY .docker/laravel-worker.conf /etc/supervisor/conf.d/laravel-worker.conf

# Copy the application files to the container
COPY . /var/www/html/

# Expose port 80
EXPOSE 80

# Start services
CMD service nginx start && php-fpm && supervisord -c /etc/supervisor/supervisord.conf
