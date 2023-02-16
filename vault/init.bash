#!/usr/bin/env bash
chmod +x ./certGenerator.bash
chmod +x ./vaultInitUnseal.bash

mkdir -p ./volumes/vault/{config,data,logs,policies,ssl} 

./certGenerator.bash

docker-compose up --build --force-recreate -d

./vaultInitUnseal.bash
