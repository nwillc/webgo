# WEBGO

This is just experiments with:

 - Go (v1.15.1)
 - Kubernetes (OSX Docker Desktop)
 - Helm (v2.9.0+, v3.+)
    - environment yaml files to env variables 
    - environment global with local overrides
 - Istio (v1.7.2)
 
The goal was to exclude Istio proxying for one site and not others:

```
webgo 2020/09/23 05:15:11 TICK
webgo 2020/09/23 05:15:12 Response status http://gobyexample.com : 200 OK
webgo 2020/09/23 05:15:12 Response status http://google.com : 200 OK
istio-proxy [2020-09-23T05:15:11.920Z "GET / HTTP/1.1" 301 - "-" "-" 0 183 38 35 "-" "Go-http-client/1.1" "6713627c-1965-96ed-983d-4576677b848c" "gobyexample.com" "143.204.151.4:80" PassthroughCluster 10.1.0.116:55436 143.204.151.4:80 10.1.0.116:47062 - allow_any
istio-proxy [2020-09-23T05:15:11.966Z "- - -" 0 - "-" "-" 524 12066 59 - "-" "-" "-" "-" "143.204.151.4:443" PassthroughCluster 10.1.0.116:50402 143.204.151.4:443 10.1.0.116:50400 - -
webgo 2020/09/23 05:15:22 TICK
webgo 2020/09/23 05:15:22 Response status http://gobyexample.com : 200 OK
webgo 2020/09/23 05:15:22 Response status http://google.com : 200 OK
```
 
 Note from the log above, istio-proxy is invoked for gobyexample.com, but not google.com.
 
## Basic Steps
 
```bash
# ./bin/istio-install.sh
# Build the docker image
./bin/docker-build-push.sh -r NAME -v VERSION
# Update Chart.yaml appVersion to the VERSION above
# helm deploy 
./bin/deploy.sh -r NAME -v VERSION
```

## Config Notes
Environment variables are exposed to the service from YAML files in `environment` folder. The YAML, containing a map named
`config` is mapped to environment variables as follows:

```yaml
config:
    max: "42"
    database:
      name: "server.name.com"
      port: "2056"
``` 

The environment variables that result will be:

```bash
CONFIG_MAX=42
CONFIG_DATABASE_NAME=server.name.com
CONFIG_DATABASE_PORT=2056
```

## Helm 2.9.0 vs Helm 3.+
 
```bash
# Remove 2.9.0
helm delete NAME --purge

# Remove 3.+
helm uninstall NAME

# Install 2.9.0
helm install CHART_PATH -name NAME

# INSTALL 3.+
helm install NAME CHART_PATH
```

## Notes:
 
  - Helm 2.9.0 issues:
    - Helm init doesn't work, see [helm-init.sh](bin/helm-init.sh) for fix.
    - Helm delete, even with `--purge` leaves running pod. Need t use `kubectl` to kill.
 - Helm 3+:
    - `helm uninstall` seems to work properly
 - I'm not using a two stage build with a `Golang` docker image.
   - Building a `Linux amd64` binary and copying that into an `Alpine` image in anticipation 
   of having to build from a very large source base in the future and wanting to avoid multi-stage build pattern.
 - Helm chart stripped back as much as possible.
