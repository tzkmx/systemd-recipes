#! /bin/bash

filename=/var/www/vhosts/system/$1/conf/nginx.conf

sed -i -e "/media[0-9]\.$1/d" $filename

for index in 4 3 2 1 ; do \
    sed -i -e "s@server_name $1;@\0\n\tserver_name media$index.$1;@" $filename ;
done
