#!/bin/bash

source /etc/profile.d/rvm.sh

sed 's/peer/trust/' -i /etc/postgresql/10/main/pg_hba.conf
sed --in-place=bak 's/pg_catalog.english/pg_catalog.russian/g' /etc/postgresql/10/main/postgresql.conf 
cp config/database.yml.sample config/database.yml 
service postgresql restart 

sudo -u postgres createuser --superuser pgsql 
sudo -u postgres createdb synch_1c_insales_test

sleep 10

bash -c "$*"

