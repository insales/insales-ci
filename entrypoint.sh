#!/bin/bash
. /etc/profile.d/rvm.sh && rvm use 2.6.2 --default

PRONTO_GITHUB_ACCESS_TOKEN=$GITHUB_TOKEN \
PRONTO_PULL_REQUEST_ID="$(jq --raw-output .number "$GITHUB_EVENT_PATH")" \
pronto run -f github_status github_pr -c origin/master
