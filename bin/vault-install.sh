#!/bin/bash

helm install vault hashicorp/vault --set "server.dev.enabled=true"
