# WEBGO

This is just experiments with:

 - Go (v1.15.1)
 - Kubernetes (OSX Docker Desktop)
 - Helm (v2.9.0+)
 
 ## Notes:
 
  - Helm 2.9.0 issues
    - Helm init doesn't work, see [helm-init.sh](bin/helm-init.sh) for fix.
    - Helm delete, even with `--purge` leaves running pod. Need t use `kubectl` to kill.
 - I'm not using a two stage build with a `Golang` docker image.
   - Building an `Linux amd64` binary and copying that into an `Alpine` image in anticipation 
   of having to build from a very large source base in the future.
 - Helm chart stripped back to a no ingress program.
    - no services
    - no ingress
    - no autoscaling