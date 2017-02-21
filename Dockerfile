FROM nginx:stable-alpine

MAINTAINER Martin Kolek <kolek@modpreneur.com>

RUN set -x \
	&& addgroup -g 82 -S www-data \
	&& adduser -u 82 -D -S -G www-data www-data

ADD docker/nginx.conf /etc/nginx/
ADD docker/symfony.conf /etc/nginx/sites-available/

RUN mkdir -p /etc/nginx/sites-enabled \
    && ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/ \
    && rm /etc/nginx/conf.d/default.conf

CMD ["nginx"]

EXPOSE 80

WORKDIR /var/app

RUN echo "modpreneur/necktie-nginx:0.3" >> /home/versions