#!/bin/bash

source ~/.nvm/nvm.sh

service mysql start

if [ -f /.firstrun ]; then
  retries=0
  until `mysql --protocol TCP -u root -e 'show databases;' > /dev/null 2>&1`; do
    if [ $retries -ge 15 ]; then
        >&2 echo "Too many retries. Aborting."
        exit 1
    fi
    retries=`expr ${retries} + 1`
    echo "Waiting for MySQL to start..."
    sleep 2
  done
  mysqladmin -u root password "root"
  mysql -uroot -proot -e "CREATE DATABASE cabin; USE cabin; SOURCE /cabin.sql;"
  rm /.firstrun
fi

#cd /app/src/api
#echo "Building /src/api"
#npm install
#echo "Starting /src/api"
#node index.js&

#cd ../app
#echo "Building /src/app"
#npm install
#echo "Running webpack"
#webpack --watch --progress&

#echo "Starting /src/app"
#npm start
/bin/bash
#sleep 5000
