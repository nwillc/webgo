#!/bin/bash

istioctl install --set profile=demo --set values.global.proxy.excludeIPRanges="172.217.0.0/16\,40.83.210.182/32\,13.64.245.217/32"
kubectl label namespace default istio-injection=enabled
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/prometheus.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/kiali.yaml

