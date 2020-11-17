#!/bin/bash

echo Installing istio 1.7.4 demo profile, prometheus and kiali.
istioctl install --set profile=demo
kubectl label namespace default istio-injection=enable
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/prometheus.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/kiali.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/grafana.yaml
