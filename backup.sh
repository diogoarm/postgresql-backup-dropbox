#!/bin/sh

set -eu

export PGPASSWORD=$POSTGRESQL_PASSWORD
POSTGRESQL_HOST_OPTS="-h $POSTGRESQL_HOST -p $POSTGRESQL_PORT -U $POSTGRESQL_USER"

echo "Creating backup for $DATABASE_NAME..."
pg_dump $POSTGRESQL_HOST_OPTS $POSTGRESQLDUMP_OPTIONS $DATABASE_NAME > $DATABASE_NAME.sql \
  | gzip $DATABASE_NAME.sql \
  | curl -X POST https://content.dropboxapi.com/2/files/upload \
    --header "Authorization: Bearer $DROPBOX_ACCESS_TOKEN" \
    --header "Dropbox-API-Arg: {\"path\": \"/$DROPBOX_PREFIX$DATABASE_NAME.sql.gz\",\"mode\": \"add\",\"autorename\": true,\"mute\": false}" \
    --header "Content-Type: application/octet-stream" \
    --data-binary @$DATABASE_NAME.sql.gz     
  | rm -f $DATABASE_NAME.sql $DATABASE_NAME.sql.gz