FROM golang:1.7.3 AS builder
WORKDIR /build
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -o webgo \
    -ldflags="-w" main.go

FROM alpine:3.12.1
RUN apk --no-cache add ca-certificates
COPY --from=builder /build/webgo webgo
CMD ["/webgo"]
