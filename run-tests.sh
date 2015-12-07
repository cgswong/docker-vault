#! /bin/bash
# Run testing.

# Set values
# Set values
pkg=${0##*/}
pkg_root=$(dirname "${BASH_SOURCE}")

# Source common script
source "${pkg_root}/common.sh"

: ${DOCKER_IMAGE:="vault"}
#: ${DOCKER_MACHINE_NAME:="vaulttest"}

export DOCKER_IMAGE
#export DOCKER_MACHINE_NAME

#eval "$(docker-machine env ${DOCKER_MACHINE_NAME})"

main() {
  versions=( "$@" )
  if [ ${#versions[@]} -eq 0 ]; then
    versions=( ?.?.? )
  fi
  versions=( "${versions[@]%/}" )
  versions=( $(printf '%s\n' "${versions[@]}"|sort -V) )

  for TAG in "${versions[@]}"; do
    export TAG
    log "${yellow}---------------[START]-------------------------${reset}"
    for test in $(ls -1 tests/*.sh); do
      source ${test}
    done
    log "${yellow}----------------[END]--------------------------${reset}"
  done
}

main
exit 0
