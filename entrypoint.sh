#!/bin/bash
source /etc/profile.d/rvm.sh

rvm use 2.5.3 --default
bundle install -j 4 --without production development

sed 's/peer/trust/' -i /etc/postgresql/10/main/pg_hba.conf

cp -v config/database.yml.sample config/database.yml 
cp -v config/secrets.sample.yml config/secrets.yml

service postgresql restart 
sleep 10

bash -c "$*"

