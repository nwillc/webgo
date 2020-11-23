# WEBGO

This is just experiments with kubernetes, helm and Istio.

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

 1. Have a docker hub repo set up
 2. `./bin/deploy.sh -b -r DOCKER_REPO_NAME -v A VERSION`
 
# K8s 
I've run this with both the Docker Desktop Kubernetes and Minikube:

  - For Docker Desktop set 4 cpus an 8g memory.
  - For Minikube `minikube start --cpus=4 --memory=16g`
    - To get 16g, docker with need 16.5g
    
# Sidecar Injection
Istio provides various controls for this, but with the Docker Desktop and Minikube clusters I could only get automatic 
injection to work.
