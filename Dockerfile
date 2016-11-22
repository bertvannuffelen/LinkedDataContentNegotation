#FROM webdevops/apache:debian-9
#  > creates an eternal loop
FROM eboraas/apache

RUN a2enmod rewrite
RUN a2enmod cgi
RUN a2enmod headers
RUN a2enmod env
RUN a2enmod log_debug
RUN a2enmod proxy
RUN a2enmod proxy_http

ADD config /config
ADD www /www
ADD scripts /scripts
ENV WEB_DOCUMENT_ROOT=/www

# check out latest version 2.4
#RUN a2enmod negotation

RUN cp /config/*.conf /etc/apache2/conf-enabled/
RUN cp /config/global/*.conf /etc/apache2/
RUN chmod -R 777 /scripts

