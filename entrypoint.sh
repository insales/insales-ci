#!/bin/bash
. /etc/profile.d/rvm.sh && rvm use 2.6.1 --default

bash -c "$*"
