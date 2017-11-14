FROM debian:stretch

WORKDIR /opt

RUN apt-get update && apt-get install -y unzip curl wget

RUN curl https://releases.hashicorp.com/consul-template/0.19.0/consul-template_0.19.0_linux_amd64.tgz -o consul-template.tgz && \
    tar -xvf consul-template.tgz && \
    rm consul-template.tgz && \
    cp consul-template /usr/bin

CMD ["consul-template","-template","/opt/logstash.ctmpl:/opt/config/logstash.conf:cat /opt/config/logstash.conf","-consul-addr","consul:8500"]

COPY logstash.ctmpl /opt/logstash.ctmpl

