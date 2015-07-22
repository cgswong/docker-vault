#!/usr/bin/env bats

@test "Confirm Vault is available" {
  run docker run --rm --name ${IMAGE} ${IMAGE}:${TAG} -help
  [ $status -eq 1 ]
}

@test "Confirm Vault version" {
  run docker run --rm --name ${IMAGE} ${IMAGE}:${TAG} version
  [[ $output =~ "Vault v${TAG}" ]]
}
