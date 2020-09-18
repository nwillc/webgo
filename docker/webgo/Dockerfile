FROM alpine:3.12.0
RUN apk add --update ca-certificates # Certificates for SSL
ADD ./bin/amd64/webgo /go/bin/webgo
ENTRYPOINT /go/bin/webgo
