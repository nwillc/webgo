#!/bin/bash

# Exclude the google class B from istio proxying.
istioctl install --set profile=demo --set values.global.proxy.excludeIPRanges="172.217.0.0/16"
kubectl label namespace default istio-injection=enabled
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/prometheus.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/kiali.yaml

