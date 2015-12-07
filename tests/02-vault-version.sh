#!/usr/bin/env bash -x
# Test case for Docker build

# Set values
pkg=${0##*/}
pkg_root=$(dirname "${BASH_SOURCE}")

# Source common script
source "${pkg_root}/../common.sh"

# main function
main() {
  log "${green}Confirming ${DOCKER_IMAGE} version${reset}"
  docker run --rm --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}:${TAG} -version
  if [ $? -eq 0 ]; then
    log "${green}[PASS] ${DOCKER_IMAGE}${reset}"
  else
    die "${DOCKER_IMAGE} version check"
  fi
}

check-env
main
