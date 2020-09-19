#!/bin/bash
set -e
set -u
set -o pipefail

NAME="nwillc/webgo"
VERSION=""

while getopts ":n:v:" OPT; do
  case "${OPT}" in
    n)
      NAME=${OPTARG}
      ;;
    v)
      VERSION=:${OPTARG}
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

echo Building "${NAME}${VERSION}"
./bin/make-alpine.sh
docker build -t ${NAME}${VERSION} -f docker/webgo/Dockerfile .
docker push ${NAME}${VERSION}

