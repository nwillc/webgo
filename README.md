# WEBGO

This is repo contains experiments with Kubernetes, Helm and Istio.

# Requirements

## Overall

 - Kubernetes (OSX Docker Desktop or Minikube)
 - [asdf](https://github.com/asdf-vm/asdf) for tool installation
 
## Getting Tools

Have `asdf` set up and then run `./bin/asdf-sync.sh` to have it sync to `.tool-versions` expectations.
 
# To Get Kubernetes and Istio Set Up

 1. Enable kubernetes in Docker Desktop
 2. Run `./bin/istio-install.sh`
 
# To Run WebGo

 1. Have a docker hub repo set up and be logged in
 2. `./bin/deploy.sh -b -r DOCKER_REPO_NAME -v A VERSION`
 
# K8s 
I've run this with both the Docker Desktop Kubernetes and Minikube:

  - For Docker Desktop set 4 cpus an 8g memory.
  - For Minikube `minikube start --cpus=4 --memory=16g`
    - To get 16g, docker will need 16.5g
    
# Helm Chart Repo
I've made the gh-pages branch into a Helm Chart Repo. This can be added:

```bash
$ helm repo add webgorepo https://nwillc.github.io/webgo/
```

And the chart there can then be used via `-C webgorepo/webgo` flag on the `deploy.sh` script.

# Sidecar Injection
Istio provides various controls for this, but with the Docker Desktop and Minikube clusters I could only get automatic 
injection to work.
