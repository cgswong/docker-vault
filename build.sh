#! /bin/bash
# #########################################
# DESC: Build images.
# #########################################

# Set values
pkg=${0##*/}
version="0.1.0"
pkg_path=$(cd $(dirname $0); pwd -P)
host=$(hostname)
logfile="$pkg_path/$pkg.log"

IMAGE="vault"
MACHINE="dev"

versions=( 0.*/ )
versions=( "${versions[@]%/}" )

machine-init() {
  # Build test VM if needed
  docker-machine ls -q | grep "${MACHINE}" &>/dev/null
  if [ $? -ne 0 ]; then
    if [ -z $create_machine ]; then
      echo "[CI] Docker machine (${MACHINE}) does not exist and auto-creation disabled. Exiting."
      exit 1
    fi
    echo "[CI] Creating Docker host (${MACHINE})..."
    docker-machine create --driver virtualbox ${MACHINE}
  else
    docker-machine ls | grep ${MACHINE} | grep Running &>/dev/null
    if [ $? -ne 0 ]; then
      echo "[CI] Starting Docker host (${MACHINE})..."
      docker-machine start ${MACHINE}
    fi
  fi
  eval "$(docker-machine env ${MACHINE})"
}

run-builds() {
  # Run builds
  for TAG in "${versions[@]}"; do
    echo "[CI] Building image: ${IMAGE}:${TAG}"
    docker build -t ${IMAGE}:${TAG} ${TAG}/
  done

  echo "[CI] All tags build okay."
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
      MACHINE="$optarg"
      ;;
    -*)
      echo "[CI] Unknown option $arg, exiting..." && exit 1
      ;;
    *)
      echo "[CI] Unknown option or missing argument for $arg, exiting."
      usage
      exit 1
      ;;
  esac
done

export MACHINE
machine-init
run-builds
