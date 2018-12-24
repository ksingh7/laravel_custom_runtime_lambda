#!/bin/bash

yum install -y php71-cli php71-mbstring php71-mysqlnd php71-opcache php71-pdo php71-pgsql zip

mkdir /tmp/layer
cd /tmp/layer
cp /opt/layer/bootstrap .
cp /opt/layer/php.ini .

mkdir bin
cp /usr/bin/php bin/

mkdir lib
for lib in libncurses.so.5 libtinfo.so.5 libpcre.so.0; do
  cp "/lib64/${lib}" lib/
done

cp /usr/lib64/libedit.so.0 lib/

mkdir php-7.1.d/
cp -a /etc/php-7.1.d/* php-7.1.d/
cp -a /etc/php-7.1.ini php-7.1.d/php.ini
cp -a /usr/lib64/php lib/

zip -r /opt/layer/php71.zip .
