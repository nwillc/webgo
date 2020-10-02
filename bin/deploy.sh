#!/bin/bash
set -e
set -u
set -o pipefail

APP=webgo
CHART="./charts/${APP}"
DEBUG=""
ENV=local
REPOSITORY="nwillc/${APP}"
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

HELM_ARGS="${HELM_ARGS} --values environment/global/config.yaml"
HELM_ARGS="${HELM_ARGS} --values environment/${ENV}/config.yaml"
HELM_ARGS="${HELM_ARGS} --set image.repository=${REPOSITORY}"
HELM_ARGS="${HELM_ARGS} --set image.tag=${VERSION}"

if [ ! -z "${DEBUG}" ]; then
  helm lint ${CHART} ${HELM_ARGS}
fi

helm upgrade --install ${HELM_ARGS} ${APP} ${DEBUG} ${CHART}
