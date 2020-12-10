#!/bin/bash
set -e
set -u
set -o pipefail

COMMAND="upgrade --install"
REPOSITORY="nwillc/webgo"
VERSION=""
BUILD="false"
CONTEXT=docker-desktop
ENVIRONMENT=local
CHART="./charts/webgo"

while getopts ":bc:de:r:v:C:" OPT; do
  case "${OPT}" in
    b)
      BUILD="true"
      ;;
    c)
      CONTEXT=${OPTARG}
      ;;
    C)
      CHART="${OPTARG}"
      ;;
    d)
      COMMAND="template"
      ;;
    e)
      ENVIRONMENT=${OPTARG}
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
  -C chart        Optionally designate the chart. Defaults to the local charts/webgo.
  -d              Debug the helm configuration w/o deploying.
  -e environment  Environment configure charts for.
  -r repository   The image repository to deploy image to.
  -v version      The version number of the image.
!
      exit 1
      ;;
  esac
done

if [ -z "${VERSION}" ]; then
  echo Version required.
  exit 1
fi

if [ ".${BUILD}" == ".true" ]; then
  ./bin/docker-build-push.sh -r "${REPOSITORY}" -v "${VERSION}"
fi

kubectx "${CONTEXT}"

CMD="helm ${COMMAND} --values environment/global/config.yaml --values environment/${ENVIRONMENT}/config.yaml --set image.repository=${REPOSITORY} --set image.tag=${VERSION} --set-string timestamp=$(date +%s) webgo ./charts/webgo"
echo ${CMD}
${CMD}
