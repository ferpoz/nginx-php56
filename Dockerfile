FROM fedora:34 

RUN dnf -y update \
    && dnf -y install nginx dnf-plugins-core \
    && dnf clean all

RUN dnf -y install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-34.noarch.rpm \
    && dnf -y install \
       https://rpms.remirepo.net/fedora/remi-release-34.rpm \
    && dnf config-manager --set-enabled remi

RUN dnf -y update \
    && dnf -y install \
       php56 \
       php56-php-bcmath \
       php56-php-cli \
       php56-php-common \
       php56-php-fpm \
       php56-php-gd \
       php56-php-mbstring \
       php56-php-mcrypt \
       php56-php-mysqlnd \
       php56-php-odbc \
       php56-php-pdo \
       php56-php-pear \
       php56-php-pecl-jsonc \
       php56-php-pecl-zip \
       php56-php-process \
       php56-php-soap \
       php56-php-xml \
       php56-runtime \
       php56-syspaths \     
    && dnf clean all

RUN mkdir /etc/nginx/sites-enabled

RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak

RUN mv /etc/opt/remi/php56/php-fpm.d/www.conf /etc/opt/remi/php56/php-fpm.d/www.conf.bak

COPY ./config/nginx.conf /etc/nginx/nginx.conf

COPY ./config/default.conf /etc/nginx/sites-enabled/default.conf

COPY ./config/www.conf /etc/opt/remi/php56/php-fpm.d/www.conf

COPY ./scripts/services.sh /usr/local/sbin

RUN chmod 755 /usr/local/sbin/services.sh

EXPOSE 80

CMD [ "/usr/local/sbin/services.sh" ]
