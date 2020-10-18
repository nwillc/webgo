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
      cat <<! >&2
script usage: $(basename $0) [-b] [-c context] [-d] [-r repository] [-v version]
  -b              Build executable.
  -c context      K8s context.
  -d              Debug the helm charts w/o deploying.
  -r repository   The image repository to deploy image to.
  -v version      The version number of the image.
!
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
