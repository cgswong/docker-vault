#! /bin/bash
# Build images.

# Set values
pkg=${0##*/}
pkg_path=$(cd $(dirname $0); pwd -P)

DOCKER_IMAGE=${1:-"vault"} ; export DOCKER_IMAGE
DOCKER_MACHINE_NAME=${2:-"citest"} ; export DOCKER_MACHINE_NAME
DOCKER_MACHINE_HDD=${DOCKER_MACHINE_HDD:-"10240"} export DOCKER_MACHINE_HDD

# set colors
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
purple=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
reset=$(tput sgr0)

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
  versions=( ?.?.? )
fi
versions=( "${versions[@]%/}" )
versions=( $(printf '%s\n' "${versions[@]}"|sort -V) )

machine-init() {
  # Build test VM if needed
  docker-machine ls -q | grep "${DOCKER_MACHINE_NAME}" &>/dev/null
  if [ $? -ne 0 ]; then
    if [ ! -z $create_machine ]; then
      echo "${red}[CI] Docker host (${DOCKER_MACHINE_NAME}) does not exist and auto-creation disabled. Exiting.${reset}"
      exit 1
    fi
    echo "${yellow}[CI] Creating Docker host (${DOCKER_MACHINE_NAME})...${reset}"
    docker-machine create --driver virtualbox ${DOCKER_MACHINE_NAME} --virtualbox-disk-size ${DOCKER_MACHINE_HDD}
  else
    docker-machine ls | grep ${DOCKER_MACHINE_NAME} | grep Running &>/dev/null
    if [ $? -ne 0 ]; then
      echo "${green}[CI] Starting Docker host (${DOCKER_MACHINE_NAME})...${reset}"
      docker-machine start ${DOCKER_MACHINE_NAME}
    fi
  fi
  eval "$(docker-machine env ${DOCKER_MACHINE_NAME})"
}

run-builds() {
  # Run builds
  for TAG in "${versions[@]}"; do
    echo "${green}[CI] Building image: ${DOCKER_IMAGE}:${TAG}${reset}"
    docker build -t ${DOCKER_IMAGE}:${TAG} ${TAG}/
  done
  echo "${green}[CI] All tags build okay.${reset}"
}


usage() {
cat <<EOM

$pkg v${version}

Create test builds. If any invalid options are specified the build process is run.

Usage: $pkg [OPTIONS]

Options:
  -h,--help               Output help (this message)
  -v,--version            Output version
  -nc,--no-create         Do not create Docker VM host
  -m=,--machine=[NAME]    Use specified name for Docker VM host (defaults to 'dev')

EOM
}

# Process command line
for arg in "$@"; do
  if test -n "$prev_arg"; then
    eval "$prev_arg=\$arg"
    prev_arg=
  fi

  case "$arg" in
      -*=*) optarg=`echo "$arg" | sed 's/[-_a-zA-Z0-9]*=//'` ;;
      *) optarg= ;;
  esac

  case $arg in
    -h | --help)
      usage && exit 0
      ;;
    -v | --version)
      echo "$pkg v${version}" && exit 0
      ;;
    -nc | --no-create)
      create_machine=0
      ;;
    -m=* | --machine=*)
      DOCKER_MACHINE_NAME="$optarg"
      ;;
    -*)
      echo "${red}[CI] Unknown option $arg, exiting...${reset}" && exit 1
      ;;
    *)
      echo "${red}[CI] Unknown option or missing argument for $arg, exiting.${reset}"
      usage
      exit 1
      ;;
  esac
done

machine-init
run-builds
