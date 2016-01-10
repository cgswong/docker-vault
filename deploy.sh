#! /bin/bash
# Deploy to Docker Registry

# Set values
# Set values
pkg=${0##*/}
pkg_root=$(dirname "${BASH_SOURCE}")

# Source common script
source "${pkg_root}/common.sh"

: ${DOCKER_IMAGE:="vault"}

export DOCKER_IMAGE

main() {
  versions=( "$@" )
  if [ ${#versions[@]} -eq 0 ]; then
    versions=( ?.?.? )
  fi
  versions=( "${versions[@]%/}" )
  versions=( $(printf '%s\n' "${versions[@]}"|sort -V) )

  for TAG in "${versions[@]}"; do
    export TAG
    log "${green}Deploying to ${1}/${DOCKER_IMAGE}:${TAG}${reset}"
    docker push ${1}/${DOCKER_IMAGE}:${TAG}
  done
}

main
