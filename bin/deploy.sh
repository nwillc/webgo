#!/bin/bash
set -e
set -u
set -o pipefail

DEBUG=""
ENV=local
REPOSITORY="nwillc/webgo"
VERSION="1.0.0"
BUILD="false"
CONTEXT=docker-desktop

while getopts ":bcdr:v:" OPT; do
  case "${OPT}" in
    b)
      BUILD="true"
      ;;
    c)
      CONTEXT=${OPTARG}
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

kubectx "${CONTEXT}"

helm upgrade --install \
  --values environment/global/config.yaml --values "environment/${ENV}/config.yaml" \
  --set image.repository="${REPOSITORY}" --set image.tag="${VERSION}" \
  webgo ${DEBUG} ./charts/webgo
