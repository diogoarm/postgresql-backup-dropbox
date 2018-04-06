#!/bin/sh

set -eu

export PGPASSWORD=$POSTGRESQL_PASSWORD
POSTGRESQL_HOST_OPTS="-h $POSTGRESQL_HOST -p $POSTGRESQL_PORT -U $POSTGRESQL_USER"
databases=$(psql $POSTGRESQL_HOST_OPTS -c "\l")

for database in $databases
do
  if [ "$database" != "information_schema" ]
  then
    echo "Creating backup for $database..."
    pgdump $POSTGRESQL_HOST_OPTS $POSTGRESQLDUMP_OPTIONS $database \
      | gzip \
      | curl -X PUT \
             -H "Authorization: Bearer $DROPBOX_ACCESS_TOKEN" \
             -T - \
             --silent \
             --output /dev/null \
             https://content.dropboxapi.com/1/files_put/auto/$DROPBOX_PREFIX$database.sql.gz
  fi
done