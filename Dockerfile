#FROM webdevops/apache:debian-9
#  > creates an eternal loop
FROM eboraas/apache

ADD config /config
ADD www /www
ADD scripts /scripts
ENV WEB_DOCUMENT_ROOT=/www

RUN a2enmod rewrite
RUN a2enmod proxy
RUN a2enmod cgi
# check out latest version 2.4
#RUN a2enmod negotation

RUN cp /config/*.conf /etc/apache2/conf-enabled/
RUN cp /config/global/*.conf /etc/apache2/
RUN chmod -R 777 /scripts

