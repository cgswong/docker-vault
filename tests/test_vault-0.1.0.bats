#!/usr/bin/env bats

@test "Confirm Vault is available" {
  run docker run --rm --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}:${VERSION} -help
  [ $status -eq 1 ]
}

@test "Confirm Vault version" {
  run docker run --rm --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}:${VERSION} version
  [[ $output =~ "Vault v${VERSION}" ]]
}
