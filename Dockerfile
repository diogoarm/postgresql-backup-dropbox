FROM alpine:edge

RUN apk update; \
	apk add postgresql-client; \
	apk add curl; \
	curl -L --insecure https://github.com/odise/go-cron/releases/download/v0.0.6/go-cron-linux.gz | zcat > /usr/local/bin/go-cron; \
	chmod u+x /usr/local/bin/go-cron; \
	rm -rf /var/cache/apk/*; \
	apk add --update bash && rm -rf /var/cache/apk/*

ENV POSTGRESQLDUMP_OPTIONS ""
ENV POSTGRESQL_HOST ""
ENV POSTGRESQL_PORT 5432
ENV POSTGRESQL_USER ""
ENV POSTGRESQL_PASSWORD ""
ENV DROPBOX_PREFIX ""
ENV DROPBOX_ACCESS_TOKEN ""
ENV DATABASE_NAME ""
ENV SCHEDULE ""

ADD run.sh run.sh
ADD backup.sh backup.sh

CMD ["sh", "run.sh"]