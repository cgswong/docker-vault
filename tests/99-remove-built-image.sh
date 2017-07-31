#!/usr/bin/env bash -x
# Test case for Docker build

# Set values
pkg=${0##*/}
pkg_root=$(dirname "${BASH_SOURCE}")

# Source common script
source "${pkg_root}/../common.sh"

# main function
main() {
  log "${green}Removing Docker image: ${DOCKER_IMAGE}:${TAG}${reset}"
  docker rmi ${DOCKER_IMAGE}:${TAG} > /dev/null
  if [ $? -eq 0 ]; then
    log "${green}[PASS] Removed ${DOCKER_IMAGE}:${TAG}${reset}"
  else
    die "Removing ${DOCKER_IMAGE}:${TAG} failed"
  fi
}

check-env
main
