#!/bin/bash
set -e
set -u
set -o pipefail

DEBUG=""
ENV=local
REPOSITORY="nwillc/webgo"
VERSION="1.0.0"
BUILD="false"

while getopts ":bdr:v:" OPT; do
  case "${OPT}" in
    b)
      BUILD="true"
      ;;
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
      echo "script usage: $(basename $0) [-n somevalue]" >&2
      exit 1
      ;;
  esac
done

if [ ".${BUILD}" == ".true" ]; then
  ./bin/docker-build-push.sh -r "${REPOSITORY}" -v "${VERSION}"
fi

helm upgrade --install \
  --values environment/global/config.yaml --values "environment/${ENV}/config.yaml" \
  --set image.repository="${REPOSITORY}" --set image.tag="${VERSION}" \
  webgo ${DEBUG} ./charts/webgo
