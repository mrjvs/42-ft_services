FROM alpine:3.12.0
WORKDIR /app

# get telegraf release
RUN wget -O telegraf.tgz https://dl.influxdata.com/telegraf/releases/telegraf-1.15.2_static_linux_amd64.tar.gz && tar -xzf telegraf.tgz

# copy files to the right places
RUN cp telegraf-1.15.2/usr/bin/telegraf /usr/bin/
RUN cp -r telegraf-1.15.2/etc/* /etc/

# config
COPY telegraf.conf /etc/telegraf/telegraf.conf

# copy entrypoint
COPY start.sh ./start.sh

ENTRYPOINT /app/start.sh
