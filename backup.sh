#!/bin/sh

set -eu

export PGPASSWORD=$POSTGRESQL_PASSWORD
POSTGRESQL_HOST_OPTS="-h $POSTGRESQL_HOST -p $POSTGRESQL_PORT -U $POSTGRESQL_USER --format tar"
today=$(date +%Y-%m-%d)

echo "Creating backup for $DATABASE_NAME..."
pg_dump $POSTGRESQL_HOST_OPTS $POSTGRESQLDUMP_OPTIONS $DATABASE_NAME > $DATABASE_NAME.backup \
  ; gzip -f $DATABASE_NAME.backup \
  ; curl -X POST https://content.dropboxapi.com/2/files/upload \
    --header "Authorization: Bearer $DROPBOX_ACCESS_TOKEN" \
    --header "Dropbox-API-Arg: {\"path\": \"/$DROPBOX_PREFIX$today/$DATABASE_NAME.backup.gz\",\"mode\": \"add\",\"autorename\": true,\"mute\": false}" \
    --header "Content-Type: application/octet-stream" \
    --data-binary @$DATABASE_NAME.backup.gz \
  ; rm -f $DATABASE_NAME.backup $DATABASE_NAME.backup.gz
