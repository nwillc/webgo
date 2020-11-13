# WEBGO

This is just experiments with kubernetes.

# Requirements

## Overall

 - Kubernetes (OSX Docker Desktop)
 - asdf for tool versioning
 
## For Kubernetes

 - Via `asdf`
    - Helm (v3.3.4)
    - Helmfile (v0.134.0)
    - Istio (v1.7.4)
 
## For The Webgo App

 - Via `asdf`
   - Go (v1.15.3) 

 
# To Get Kubernetes Set Up

 1. Enable kubernetes in Docker Desktop
 2. Run `./bin/istio-install.sh`
 
 
# To Run WebGo

 1. Have a docker hub repo set up
 2. `./bin/deploy.sh -b -r DOCKER_REPO_NAME -v A VERSION`