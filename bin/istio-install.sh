#!/bin/bash

istioctl install --set profile=demo --set values.global.proxy.includeIPRanges="10.96.0.0/12"
kubectl label namespace default istio-injection=enabled

