FROM alpine:latest
MAINTAINER Ben Mildren

RUN apk add --update bash curl sed && rm -rf /var/cache/apk/*
RUN apk add --update python py-yaml py-pip && rm -rf /var/cache/apk/*
CMD ["/bin/true"]
