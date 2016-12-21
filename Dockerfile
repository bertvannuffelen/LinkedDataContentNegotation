#-----------------------------------------------------------------------------------------------------#   
# use the official Docker container
#
# official container 
#     * deploys the build from the apache.org downloads page
#     * does not come with the supporting tools to configure the webservice as in a Debian distribution
#     * make logs only accessible via the docker logs streams, so no persistence
# 
# This Docker configuration is a minor adaptation to the Official container setup. 
# Extra steps are in the layers for documenentation purpose
#-----------------------------------------------------------------------------------------------------#   
FROM httpd:2.4

# make logs persistent in /logs
RUN mkdir -p /logs && chmod -R 666 /logs

# config directory holds the configuration
ADD config /config
    # activates the necessary modules
COPY config/httpd.conf /usr/local/apache2/conf/httpd.conf
    # vhosts configuration:
    # aliases /scripts with cgi-bin
    # sets logs to point to /logs
COPY config/httpd-vhosts.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf

# scripts directory is the cgi-bin for the config
ADD scripts /scripts
RUN chmod -R 555 /scripts

# www directory holds the document root
ADD www /www
RUN rm -rf /usr/local/apache2/htdocs && ln -s /www /usr/local/apache2/htdocs



