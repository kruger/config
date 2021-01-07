#!/bin/bash

# Example:
# rclone.sh iso http://www.mysite.com "--dry-run --stats 30s"

UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36"

if [ "$1" != "" ] && [ "$2" != "" ]; then
        FILTER=$1
        URL=$2
else
        echo  "ERROR:  siterip.sh [WHAT] [FROM]"
        exit 1
fi

export RCLONE_CONFIG_ZZ_TYPE=http
export RCLONE_CONFIG_ZZ_URL=$URL

rclone copy -vv -I --no-traverse --checkers 16 --user-agent "$UA" --fast-list --stats 30s --filter-from /etc/rclone/$FILTER zz: . $3

