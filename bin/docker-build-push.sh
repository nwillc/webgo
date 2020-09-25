#!/bin/bash
set -e
set -u
set -o pipefail

REPOSITORY="nwillc/webgo"
VERSION=""

while getopts ":r:v:" OPT; do
  case "${OPT}" in
    r)
      REPOSITORY=${OPTARG}
      ;;
    v)
      VERSION=${OPTARG}
      ;;
    :)
      echo "Error: -${OPTARG} requires an argument."
      exit 1
      ;;
    *)
      echo "script usage: $(basename $0) [-n somevalue]" >&2
      exit 1
      ;;
  esac
done

echo Building "${REPOSITORY}:${VERSION}"
./bin/make-alpine.sh
docker build -t "${REPOSITORY}:${VERSION}" -f docker/webgo/Dockerfile .
docker push "${REPOSITORY}:${VERSION}"

