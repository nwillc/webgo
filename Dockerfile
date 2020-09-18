FROM golang:1.15-alpine AS build

WORKDIR /src/
COPY main.go go.* /src/
RUN CGO_ENABLED=0 go build -o /bin/webgo

FROM scratch
COPY --from=build /bin/webgo /bin/webgo
ENTRYPOINT ["/bin/webgo"]
