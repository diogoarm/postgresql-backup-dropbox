#!/bin/sh
set -e

if [ "${SCHEDULE}" = "" ]; then
  sh backup.sh
else
  exec go-cron "$SCHEDULE" /bin/sh backup.sh
fi