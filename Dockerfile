FROM alpine:3.12.0
ADD bin/amd64/webgo /go/bin/webgo
ENTRYPOINT /go/bin/webgo
