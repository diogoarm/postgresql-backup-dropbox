FROM alpine:edge
LABEL maintainer="diogo.arm@gmail.com"

ADD install.sh install.sh
RUN sh install.sh && rm install.sh

ENV POSTGRESQLDUMP_OPTIONS ""
ENV POSTGRESQL_HOST ""
ENV POSTGRESQL_PORT 5432
ENV POSTGRESQL_USER ""
ENV POSTGRESQL_PASSWORD ""
ENV DROPBOX_PREFIX ""
ENV DROPBOX_ACCESS_TOKEN ""
ENV SCHEDULE ""

ADD run.sh run.sh
ADD backup.sh backup.sh

CMD ["sh", "run.sh"]