#!/bin/bash

echo Installing istio 1.8, prometheus, kiali, grafana.
echo Configuring default namespace to inject istio sidecars.

if [  ! -d istio ]; then
    mkdir istio
    cd istio
    curl -L https://istio.io/downloadIstio | sh -
fi

cd istio/istio-1.8.0

kubectl create namespace istio-system
helm install --namespace istio-system istio-base manifests/charts/base  --set global.jwtPolicy=first-party-jwt
helm install --namespace istio-system istiod manifests/charts/istio-control/istio-discovery \
    --set global.hub="docker.io/istio" --set global.tag="1.8.0" --set global.jwtPolicy=first-party-jwt
kubectl apply -f samples/addons/prometheus.yaml
kubectl apply -f samples/addons/kiali.yaml
kubectl apply -f samples/addons/grafana.yaml

kubectl label namespace default istio-injection=enabled

