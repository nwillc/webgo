#!/bin/bash
set -e
set -u
set -o pipefail

DEBUG=""
ENV=local
REPOSITORY="nwillc/webgo"
VERSION="1.0.0"

while getopts ":dr:v:" OPT; do
  case "${OPT}" in
    d)
      DEBUG="--dry-run --debug"
      ;;
    r)
      REPOSITORY=${OPTARG}
      ;;
    v)
      VERSION=${OPTARG}
      ;;
    *)
      echo "script usage: $(basename $0) [-b] [-d] [-r repository] [-v version]" >&2
      exit 1
      ;;
  esac
done

helm upgrade --install \
  --values environment/global/config.yaml --values "environment/${ENV}/config.yaml" \
  --set image.repository="${REPOSITORY}" --set image.tag="${VERSION}" \
  webgo ${DEBUG} ./charts/webgo
