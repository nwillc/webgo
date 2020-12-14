#!/bin/bash
set -e
set -u
set -o pipefail

BUILD="false"
CHART="./charts/webgo"
COMMAND="upgrade --install"
CONTEXT=docker-desktop
DIFF=""
ENVIRONMENT=local
REPOSITORY="nwillc/webgo"
VERSION=""

while getopts ":bc:dDe:r:v:C:" OPT; do
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
    D)
      DIFF=true
      COMMAND="diff upgrade"
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
  -D              Diff the helm chart.
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

if [ -n "${DIFF}" ]; then
  if [ -z "$(helm plugin list | grep diff)" ]; then
    helm plugin install https://github.com/databus23/helm-diff
  fi
fi

if [ ".${BUILD}" == ".true" ]; then
  ./bin/docker-build-push.sh -r "${REPOSITORY}" -v "${VERSION}"
fi

kubectx "${CONTEXT}"

CMD="helm ${COMMAND} --values environment/global/config.yaml --values environment/${ENVIRONMENT}/config.yaml --set image.repository=${REPOSITORY} --set image.tag=${VERSION} --set-string timestamp=$(date +%s) webgo ./charts/webgo"
echo ${CMD}
${CMD}
