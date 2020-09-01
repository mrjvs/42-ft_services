FROM alpine:3.12.0
WORKDIR /app

# get influx files
RUN wget -O influx.tgz https://dl.influxdata.com/influxdb/releases/influxdb-1.8.1-static_linux_amd64.tar.gz && tar -xzf influx.tgz

# move files to the right places
RUN mkdir -p /etc/influxdb && mv influxdb-1.8.1-1/influxdb.conf /etc/influxdb/influxdb.conf
RUN cp influxdb-1.8.1-1/influx* /usr/bin/

EXPOSE 8086
VOLUME "/var/lib/influxdb"

ENTRYPOINT influxd
