#!/usr/bin/env bash -x
# Common enviornment setup

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

# Write messages to screen
log() {
  echo "$(date +"%F %T") $(hostname) [${pkg}] $1"
}

# Write exit failure messages to syslog and exit with failure code (i.e. non-zero)
die() {
  log "${red}[FAIL] $1${reset}" && exit 1
}

# Housekeeping env check
check-env() {
  [ -z ${DOCKER_IMAGE} ] && die "DOCKER_IMAGE env variable must be set!"
  [ -z ${TAG} ] && die "TAG env variable must be set!"
}
