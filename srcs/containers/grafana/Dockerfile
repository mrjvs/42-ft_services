FROM alpine:3.12.0
WORKDIR /app

RUN apk add --no-cache libc6-compat

RUN wget -O grafana.tar.gz https://dl.grafana.com/enterprise/release/grafana-enterprise-7.1.3.linux-amd64.tar.gz && \
    tar -zxvf grafana.tar.gz

RUN mv grafana-7.1.3 /grafana
RUN mv /grafana/bin/* /usr/local/bin/

COPY ./templates/dashboard.json ./templates/dashboard.json

COPY dashboard-provisioning.yaml /grafana/conf/provisioning/dashboards/sample.yaml
COPY datasource-provisioning.yaml /grafana/conf/provisioning/datasources/sample.yaml

COPY start.sh /start.sh

VOLUME ["/grafana/data"]
EXPOSE 3000

ENTRYPOINT /start.sh
