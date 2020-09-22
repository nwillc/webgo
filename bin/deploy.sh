#!/bin/bash
set -e
set -u
set -o pipefail

DEBUG=""
ENV=local

while getopts ":d" OPT; do
  case "${OPT}" in
    d)
      DEBUG="--dry-run --debug"
      ;;
    *)
      echo "script usage: $(basename $0) [-n somevalue]" >&2
      exit 1
      ;;
  esac
done

helm upgrade --install --values environment/global/config.yaml --values "environment/${ENV}/config.yaml" webgo ${DEBUG} ./charts/webgo
