#! /usr/bin/env bash
# Add files for each version.

set -e

# Set values
pkg=${0##*/}
pkg_root=$(dirname "${BASH_SOURCE}")

# Source common script
source "${pkg_root}/common.sh"

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
  versions=( ?.?.? )
fi
versions=( "${versions[@]%/}" )
versions=( $(printf '%s\n' "${versions[@]}"|sort -V) )

dlVersions=$(curl -sSL 'http://dl.bintray.com/mitchellh/vault' | sed -rn 's!.*?>(vault_)?([0-9]+\.[0-9]+\.[0-9])_linux_amd64.zip<.*!    \2!gp' | sort -V | uniq)
for version in "${versions[@]}"; do
  log "${yellow}Updating version: ${version}${reset}"
  sed -e 's/%%VERSION%%/'"$version"'/' < Dockerfile.tpl > "$version/Dockerfile"
done
log "${green}Complete${reset}"
