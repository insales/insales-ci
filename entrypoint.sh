#!/bin/bash

source /etc/profile.d/rvm.sh
rvm use 2.3.7 --default
bundle install --without production development --clean --force --retry=3 --jobs=4

sed 's/peer/trust/' -i /etc/postgresql/10/main/pg_hba.conf

cp config/database.yml.sample config/database.yml 
service postgresql restart 

sleep 10

sudo -u postgres createuser --superuser pgsql 
sudo -u postgres createuser --superuser kladr_dev

bash -c "$*"

