#! /bin/bash
# #########################################
# DESC: Run testing.
# #########################################

SLEEP=10
# Exit immediately upon failure and carry failures over pipes
set -eo pipefail

IMAGE="vault" ; export IMAGE
MACHINE=${MACHINE:-"dev"} ; export MACHINE
eval "$(docker-machine env ${MACHINE})"

versions=( 0.*/ )
versions=( "${versions[@]%/}" )

for TAG in "${versions[@]}"; do
  echo "[CI] -----------------------------------------------"
  echo "[CI] Running tests for: ${IMAGE}:${TAG}"
  export TAG
  if [[ "$TAG" == "0.1.0" ]]; then
    bats tests/test_vault-0.1.0.bats
  else
    bats tests
  fi
done

echo "[CI] ${IMAGE} tests okay on all tags."
