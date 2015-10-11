#! /usr/bin/env bash
# Add files for each version.

set -e

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

# Script directory
cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
  versions=( ?.?.? )
fi
versions=( "${versions[@]%/}" )
versions=( $(printf '%s\n' "${versions[@]}"|sort -V) )

dlVersions=$(curl -sSL 'http://dl.bintray.com/mitchellh/vault' | sed -rn 's!.*?>(vault_)?([0-9]+\.[0-9]+\.[0-9])_linux_amd64.zip<.*!    \2!gp' | sort -V | uniq)
for version in "${versions[@]}"; do
  echo "${yellow}Updating version: ${version}${reset}"
  cp docker-entrypoint.sh "${version}/" &>/dev/null
  sed -e 's/%%VERSION%%/'"$version"'/' < Dockerfile.tpl > "$version/Dockerfile"
done
echo "${green}Complete${reset}"
