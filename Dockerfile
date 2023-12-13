FROM php:8.2-cli-bullseye

LABEL org.opencontainers.image.title="Unit (php8.2)"
LABEL org.opencontainers.image.description="Nginx Unit with Php 8.2 and few extensions."
LABEL org.opencontainers.image.source="https://github.com/theraw"
LABEL org.opencontainers.image.documentation="https://github.com/theraw/nginx-unit-php82"
LABEL org.opencontainers.image.vendor="Aliens from Mars <raw@dopehosting.net>"
LABEL org.opencontainers.image.version="1.0.0"

RUN set -ex \
    && apt-get update \
    && apt-get -y install --no-install-recommends --no-install-suggests -y ca-certificates mercurial build-essential libssl-dev libpcre2-dev curl pkg-config redis-server supervisor \
    && apt-get -y install zlib1g zlib1g-dev libpng-dev libbz2-dev libcurl4-openssl-dev libxml2-dev libenchant-2-dev libgmp-dev libonig-dev unixodbc-dev libevent-dev libgeoip-dev libyaml-dev libssh2-1-dev libzip-dev libxslt-dev libmemcached-dev libtidy-dev libargon2-dev libsodium-dev libsnmp-dev libjpeg62-turbo-dev libfreetype6-dev libpspell-dev libpq-dev libsqlite3-dev libkrb5-dev libc-client-dev \
    && apt-get install -y libmagickwand-dev --no-install-recommends \
    && pecl install redis \
    && pecl install apcu \
    && pecl install imagick \
    && pecl install memcache \
    && pecl install memcached \
    && pecl install mongodb \
    && pecl install oauth \
    && pecl install ssh2 \
    && pecl install yaml \
    && pecl install grpc \
    && docker-php-ext-install -j$(nproc) sockets \
    && pecl install event \
    && pecl install igbinary \
    && pecl install mailparse \
    && pecl install raphf \
    && pecl install swoole \
    && pecl install timezonedb \
    && pecl install uploadprogress \
    && pecl install uuid
RUN docker-php-ext-install bcmath \
    && docker-php-ext-enable redis \
    && docker-php-ext-enable apcu \
    && docker-php-ext-enable imagick \
    && docker-php-ext-enable memcache \
    && docker-php-ext-enable memcached \
    && docker-php-ext-enable mongodb \
    && docker-php-ext-enable oauth \
    && docker-php-ext-enable ssh2 \
    && docker-php-ext-enable yaml \
    && docker-php-ext-enable grpc \
    && docker-php-ext-enable event \
    && docker-php-ext-enable igbinary \
    && docker-php-ext-enable mailparse \
    && docker-php-ext-enable raphf \
    && docker-php-ext-enable swoole \
    && docker-php-ext-enable timezonedb \
    && docker-php-ext-enable uploadprogress \
    && docker-php-ext-enable uuid \
    && docker-php-ext-install -j$(nproc) opcache && docker-php-ext-enable opcache \
    && docker-php-ext-install -j$(nproc) bz2 \
    && docker-php-ext-install -j$(nproc) calendar \
    && docker-php-ext-install -j$(nproc) ctype \
    && docker-php-ext-install -j$(nproc) curl \
    && docker-php-ext-install -j$(nproc) dba \
    && docker-php-ext-install -j$(nproc) dom \
    && docker-php-ext-install -j$(nproc) enchant \
    && docker-php-ext-install -j$(nproc) exif \
    && docker-php-ext-install -j$(nproc) ffi \
    && docker-php-ext-install -j$(nproc) fileinfo \
    && docker-php-ext-install -j$(nproc) filter \
    && docker-php-ext-install -j$(nproc) ftp \
    && docker-php-ext-configure gd --with-freetype --with-jpeg; docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) gettext \
    && docker-php-ext-install -j$(nproc) gmp \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl; docker-php-ext-install -j$(nproc) imap \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-install -j$(nproc) mbstring \
    && docker-php-ext-install -j$(nproc) mysqli \
    && docker-php-ext-install -j$(nproc) pdo \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && docker-php-ext-install -j$(nproc) pdo_sqlite \
    && docker-php-ext-install -j$(nproc) pgsql \
    && docker-php-ext-install -j$(nproc) phar \
    && docker-php-ext-install -j$(nproc) posix \
    && docker-php-ext-install -j$(nproc) pspell \
    && docker-php-ext-install -j$(nproc) shmop \
    && docker-php-ext-install -j$(nproc) simplexml \
    && docker-php-ext-install -j$(nproc) snmp \
    && docker-php-ext-install -j$(nproc) soap \
    && docker-php-ext-install -j$(nproc) sockets \
    && docker-php-ext-install -j$(nproc) sodium \
    && docker-php-ext-install -j$(nproc) sysvmsg \
    && docker-php-ext-install -j$(nproc) sysvsem \
    && docker-php-ext-install -j$(nproc) sysvshm \
    && docker-php-ext-install -j$(nproc) tidy \
    && docker-php-ext-install -j$(nproc) xml \
    && docker-php-ext-install -j$(nproc) xsl \
    && docker-php-ext-install -j$(nproc) zip \
    && apt-get -y purge zlib1g zlib1g-dev libpng-dev libmagickwand-dev libbz2-dev libcurl4-openssl-dev libxml2-dev libenchant-2-dev libgmp-dev libonig-dev unixodbc-dev libevent-dev libgeoip-dev libyaml-dev libssh2-1-dev libzip-dev libxslt-dev libmemcached-dev libtidy-dev libargon2-dev libsodium-dev libsnmp-dev libjpeg62-turbo-dev libfreetype6-dev libpspell-dev libpq-dev libsqlite3-dev \
    && apt-get autoremove -y; apt-get clean; apt-get autoclean; rm -rf /var/lib/apt/lists/*
RUN set -ex \
    && savedAptMark="$(apt-mark showmanual)" \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y ca-certificates mercurial build-essential libssl-dev libpcre2-dev curl pkg-config \
    && mkdir -p /usr/lib/unit/modules /usr/lib/unit/debug-modules \
    && mkdir -p /usr/src/unit \
    && cd /usr/src/unit \
    && hg clone -u 1.31.1-1 https://hg.nginx.org/unit \
    && cd unit \
    && NCPU="$(getconf _NPROCESSORS_ONLN)" \
    && DEB_HOST_MULTIARCH="$(dpkg-architecture -q DEB_HOST_MULTIARCH)" \
    && CC_OPT="$(DEB_BUILD_MAINT_OPTIONS="hardening=+all,-pie" DEB_CFLAGS_MAINT_APPEND="-Wp,-D_FORTIFY_SOURCE=2 -fPIC" dpkg-buildflags --get CFLAGS)" \
    && LD_OPT="$(DEB_BUILD_MAINT_OPTIONS="hardening=+all,-pie" DEB_LDFLAGS_MAINT_APPEND="-Wl,--as-needed -pie" dpkg-buildflags --get LDFLAGS)" \
    && CONFIGURE_ARGS_MODULES="--prefix=/usr \
                --statedir=/var/lib/unit \
                --control=unix:/var/run/control.unit.sock \
                --runstatedir=/var/run \
                --pid=/var/run/unit.pid \
                --logdir=/var/log \
                --log=/var/log/unit.log \
                --tmpdir=/var/tmp \
                --user=unit \
                --group=unit \
                --openssl \
                --libdir=/usr/lib/$DEB_HOST_MULTIARCH" \
    && CONFIGURE_ARGS="$CONFIGURE_ARGS_MODULES \
                --njs" \
    && make -j $NCPU -C pkg/contrib .njs \
    && export PKG_CONFIG_PATH=$(pwd)/pkg/contrib/njs/build \
    && ./configure $CONFIGURE_ARGS --cc-opt="$CC_OPT" --ld-opt="$LD_OPT" --modulesdir=/usr/lib/unit/debug-modules --debug \
    && make -j $NCPU unitd \
    && install -pm755 build/sbin/unitd /usr/sbin/unitd-debug \
    && make clean \
    && ./configure $CONFIGURE_ARGS --cc-opt="$CC_OPT" --ld-opt="$LD_OPT" --modulesdir=/usr/lib/unit/modules \
    && make -j $NCPU unitd \
    && install -pm755 build/sbin/unitd /usr/sbin/unitd \
    && make clean \
    && /bin/true \
    && ./configure $CONFIGURE_ARGS_MODULES --cc-opt="$CC_OPT" --modulesdir=/usr/lib/unit/debug-modules --debug \
    && ./configure php \
    && make -j $NCPU php-install \
    && make clean \
    && ./configure $CONFIGURE_ARGS_MODULES --cc-opt="$CC_OPT" --modulesdir=/usr/lib/unit/modules \
    && ./configure php \
    && make -j $NCPU php-install \
    && cd \
    && rm -rf /usr/src/unit \
    && for f in /usr/sbin/unitd /usr/lib/unit/modules/*.unit.so; do \
        ldd $f | awk '/=>/{print $(NF-1)}' | while read n; do dpkg-query -S $n; done | sed 's/^\([^:]\+\):.*$/\1/' | sort | uniq >> /requirements.apt; \
       done \
    && apt-mark showmanual | xargs apt-mark auto > /dev/null \
    && { [ -z "$savedAptMark" ] || apt-mark manual $savedAptMark; } \
    && ldconfig \
    && mkdir -p /var/lib/unit/ \
    && mkdir -p /docker-entrypoint.d/ \
    && groupadd --gid 1000 unit \
    && useradd \
         --uid 1000 \
         --gid unit \
         --no-create-home \
         --home /nonexistent \
         --comment "unit user" \
         --shell /bin/false \
         unit \
    && apt-get update \
    && apt-get --no-install-recommends --no-install-suggests -y install curl $(cat /requirements.apt) \
    && apt-get purge -y --auto-remove build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f /requirements.apt \
    && ln -sf /dev/stdout /var/log/unit.log \
    &&  rm -rf  /var/lib/unit/* \
    && apt-get purge -y \
        libc-client-dev \
        libkrb5-dev \
        libicu-dev \
        libmagickwand-dev \
        libzip-dev

COPY docker-entrypoint.sh /usr/local/bin/
COPY welcome.* /usr/share/unit/welcome/
COPY supervisor.ini /etc/supervisor/conf.d/supervisord.conf

RUN chown -R unit:unit /usr/local/bin/docker-entrypoint.sh && chmod +x /usr/local/bin/docker-entrypoint.sh

STOPSIGNAL SIGTERM

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
EXPOSE 80
#CMD ["unitd", "--no-daemon", "--control", "unix:/var/run/control.unit.sock"]
#CMD /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
