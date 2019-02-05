FROM alpine

RUN apk add --no-cache curl

WORKDIR /
COPY update-lb.sh .
RUN chmod 755 /update-lb.sh

ENTRYPOINT ["/update-lb.sh add"]
