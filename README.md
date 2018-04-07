# postgresql-backup-dropbox

Backup PostgreSQL to Dropbox (supports periodic backups & multi files)

## Basic Usage

```
$ docker run \
  --name postgresql_backup \
  -d \
  --restart=always \
  --log-opt max-size=1m \
  --log-opt max-file=5 \
  -e POSTGRESQL_USER=root \
  -e POSTGRESQL_PASSWORD=root \
  -e POSTGRESQL_HOST=localhost \
  -e DROPBOX_ACCESS_TOKEN=YOUR_TOKEN \
  -e SCHEDULE=@daily \
  -e DATABASE_NAME=databasename
  diogoarm/postgresql-backup-dropbox
```

## Environment variables

- `POSTGRESQLDUMP_OPTIONS` pg_dump options
- `POSTGRESQL_HOST` the postgresql host *required*
- `POSTGRESQL_PORT` the postgresql port (default: 5432)
- `POSTGRESQL_USER` the postgresql user *required*
- `POSTGRESQL_PASSWORD` the postgresql password *required*
- `DROPBOX_PREFIX` path prefix in your Dropbox (default: empty)
- `DROPBOX_ACCESS_TOKEN` your Dropbox API access token *required*
- `SCHEDULE` backup schedule time, see explainatons below
- `DATABASE_NAME` the postgresql databasename *required*

### Automatic Periodic Backups

You can additionally set the `SCHEDULE` environment variable like `-e SCHEDULE="@daily"` to run the backup automatically.

More information about the scheduling can be found [here](http://godoc.org/github.com/robfig/cron#hdr-Predefined_schedules).

## How to get Dropbox API token

Visit [the Dropbox app creation page](https://www.dropbox.com/developers/apps/create), and fill following fields in there.

1. Choose an API ... Dropbox API
2. Choose the type of access you need ... App folder
3. Name your app ... Your favorite name. This will be a folder name.

![](https://cdn.suin.io/542/1.png)

Once an application have created, you should press "Generate" button to generate your access token:

![](https://cdn.suin.io/542/2.png)