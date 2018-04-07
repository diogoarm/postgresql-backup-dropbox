#!/bin/sh

set -eu

export PGPASSWORD=$POSTGRESQL_PASSWORD
POSTGRESQL_HOST_OPTS="-h $POSTGRESQL_HOST -p $POSTGRESQL_PORT -U $POSTGRESQL_USER"

echo "Creating backup for $DATABASE_NAME..."
pg_dump $POSTGRESQL_HOST_OPTS $POSTGRESQLDUMP_OPTIONS $DATABASE_NAME > $DATABASE_NAME.sql \
  | gzip $DATABASE_NAME.sql \
  | curl -v -X PUT \
          -H "Authorization: Bearer $DROPBOX_ACCESS_TOKEN" \
          -T - \
          --silent \
          --output /dev/null \
          https://content.dropboxapi.com/1/files_put/auto/$DATABASE_NAME.sql.gz
rm -f $DATABASE_NAME.sql $DATABASE_NAME.sql.gz