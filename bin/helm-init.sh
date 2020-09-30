#!/bin/bash

echo Only needed by > 3.x Istio...
isioctl version

read -rp "Required only of 2.x helm - Continue (N/y)" CONTINUE
if [ "${CONTINUE}" != "y" ]; then
  exit 0
fi

kubectl create serviceaccount tiller --namespace kube-system
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller --override spec.selector.matchLabels.'name'='tiller',spec.selector.matchLabels.'app'='helm' --output yaml | sed 's@apiVersion: extensions/v1beta1@apiVersion: apps/v1@' | kubectl apply -f -
