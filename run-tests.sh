#! /bin/bash
# Run testing.

# Set values
pkg=${0##*/}
pkg_path=$(cd $(dirname $0); pwd -P)

# set colors
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
purple=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
reset=$(tput sgr0)

DOCKER_IMAGE=${1:-"vault"} ; export DOCKER_IMAGE
DOCKER_MACHINE_NAME=${DOCKER_MACHINE_NAME:-"citest"} ; export DOCKER_MACHINE_NAME
eval "$(docker-machine env ${MACHINE})"

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
  versions=( ?.?.? )
fi
versions=( "${versions[@]%/}" )
versions=( $(printf '%s\n' "${versions[@]}"|sort -V) )

for VERSION in "${versions[@]}"; do
  echo "${green}[CI] -----------------------------------------------"
  echo "${green}[CI] Running tests for: ${DOCKER_IMAGE}:${VERSION}${reset}"
  export VERSION
  bats tests
done
echo "${yellow}[CI] ${DOCKER_IMAGE} tests completed on all tags.${reset}"
