#!/bin/sh

/config/bin/replace-env.sh /usr/local/apache2/conf/extra/httpd-vhosts.conf

# sync on initial start 
if [ ! -d /www/context ] ; then
   /scripts/update.sh
fi

httpd-foreground
