# Tahap 1: Build frontend Vue
FROM node:22.16.0-alpine3.21 AS frontend

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY resources ./resources
COPY vite.config.js ./
RUN npm run build


# Tahap 2: Siapkan PHP dan dependency produksi
FROM php:8.4-cli-bookworm AS php-build

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        unzip \
        $PHPIZE_DEPS \
        libonig-dev \
    && docker-php-ext-install pdo_mysql mbstring \
    && apt-get purge -y --auto-remove $PHPIZE_DEPS \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2.8.11 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Instal dependency produksi terlebih dahulu
COPY composer.json composer.lock ./

RUN composer install \
    --no-dev \
    --no-interaction \
    --prefer-dist \
    --optimize-autoloader \
    --no-scripts

# Salin source code dan optimalkan autoloader
COPY . .

# Hapus cache package lama dan buat ulang autoloader produksi
RUN rm -f bootstrap/cache/packages.php bootstrap/cache/services.php \
    && composer dump-autoload \
        --no-dev \
        --optimize


# Tahap 3: Image runtime minimal
FROM php:8.4-cli-bookworm AS runtime

RUN apt-get update \
    && apt-get install -y --no-install-recommends libonig5 \
    && rm -rf /var/lib/apt/lists/*

# Salin ekstensi PHP yang sudah dibangun
COPY --from=php-build /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=php-build /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

WORKDIR /var/www/html

# Buat pengguna non-root
RUN groupadd --system app \
    && useradd --system \
        --gid app \
        --home-dir /var/www/html \
        --shell /usr/sbin/nologin \
        app \
    && mkdir -p storage/framework/cache \
        storage/framework/sessions \
        storage/framework/views \
        bootstrap/cache

# Salin aplikasi, dependency dan hasil build Vue
COPY --from=php-build --chown=app:app /var/www/html/ /var/www/html/
COPY --from=frontend --chown=app:app /app/public/build/ /var/www/html/public/build/

RUN chown -R app:app storage bootstrap/cache

EXPOSE 8000

# Jalankan sebagai pengguna non-root
USER app

# Periksa apakah aplikasi merespons HTTP 200
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
    CMD ["php", "-r", "$h=@get_headers('http://127.0.0.1:8000'); exit($h && str_contains($h[0], '200') ? 0 : 1);"]

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]