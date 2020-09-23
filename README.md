# WEBGO

This is just experiments with:

 - Go (v1.15.1)
 - Kubernetes (OSX Docker Desktop)
 - Helm (v2.9.0+, v3.+)
    - environment yaml files to env variables 
    - environment global with local overrides
 - Istio (v1.7.2)
 
The goal was to exclude Istio proxying one site and not others. 
 
## Basic Steps
 
```bash
# ./bin/istio-install.sh
# Build the docker image
./bin/docker-build-push.sh -n NAME -v VERSION
# Update Chart.yaml appVersion to the VERSION above
# helm deploy 
./bin/deploy.sh
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
