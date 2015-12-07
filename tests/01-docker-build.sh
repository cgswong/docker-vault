#!/usr/bin/env bash -x
# Test case for Docker build

# Set values
pkg=${0##*/}
pkg_root=$(dirname "${BASH_SOURCE}")

# Source common script
source "${pkg_root}/../common.sh"

# main function
main() {
  log "${green}Building Docker image: ${DOCKER_IMAGE}:${TAG}${reset}"
  docker build -t ${DOCKER_IMAGE}:${TAG} ${TAG}/
  if [ $? -eq 0 ]; then
    log "${green}[PASS] Build ${DOCKER_IMAGE}:${TAG}${reset}"
  else
    die "Build ${DOCKER_IMAGE}:${TAG}"
  fi
}

check-env
main
