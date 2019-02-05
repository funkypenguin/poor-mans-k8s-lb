FROM alpine

ARG BUILD_DATE
ARG VCS_REF

# Good docker practice, plus we get microbadger badges
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/poor-mans-k8s-lb/turtlecoind.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="2.2-r1"

RUN apk add --no-cache curl

WORKDIR /
COPY update-lb.sh .
RUN chmod 755 /update-lb.sh

ENTRYPOINT ["/update-lb.sh add"]
