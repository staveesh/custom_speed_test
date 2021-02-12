FROM openjdk:8-jdk-alpine

RUN mkdir -p /mobiperf

COPY src /mobiperf/src

COPY *.sh /mobiperf/

COPY supervisord.conf /etc/supervisord.conf

RUN apk update && apk add --no-cache supervisor

EXPOSE 6001 6002 6003 31341

WORKDIR /mobiperf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]