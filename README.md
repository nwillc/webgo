# WEBGO

This is just experiments with kubernetes.

# Requirements

## Overall

 - Kubernetes (OSX Docker Desktop)
 - asdf for tool versioning
 
## Getting Tools

Have `asdf` set up and then run `./bin/asdf-sync.sh` to have it sync to `.tool-versions` expectations.
 
# To Get Kubernetes Set Up

 1. Enable kubernetes in Docker Desktop
 2. Run `./bin/istio-install.sh`
 
 
# To Run WebGo

 1. Have a docker hub repo set up
 2. `./bin/deploy.sh -b -r DOCKER_REPO_NAME -v A VERSION`