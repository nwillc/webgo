# WEBGO

This is just experiments with:

 - Go (v1.15.1)
 - Kubernetes (OSX Docker Desktop)
 - Helm (v2.9.0+)
 
## Basic Steps
 
```bash
# Build the docker image
./bin/docker-build-push.sh -n NAME -v VERSION
# Check chart has repository equal to NAME
# Check chart has appVersion equal to VERSION
helm install webgo ./charts/webgo
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
