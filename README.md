# WEBGO

This is just experiments with:

 - asdf for tool versioning
 - Go (v1.15.3)
 - Kubernetes (OSX Docker Desktop)
 - Helm (v3.3.4)
    - environment yaml files to env variables 
    - environment global with local overrides
 - Helmfile (v0.134.0)
 - Istio (v1.7.4)
 
## Goals

 - Configure app in cluster via `helm`
 - Use `helmfile` to deploy app
 - Use `Istio` and `Kiali` for observability
 
## Requirements

 - Have [asdf](https://github.com/asdf-vm/asdf) installed
   - Review the `.tool-versions` file and add needed plugins and installs
 - Have Docker Desktop with it's kubernetes cluster running
