#!/bin/bash

set -x

export $(cat .env | xargs | tr -d '\r')

vault_init=$(curl -k --request POST \
   --header "Content-Type: application/json" \
   --data '{"secret_shares": 1, "secret_threshold": 1}' \
   --url $VAULT_ADDR/v1/sys/init > vault.json)

VAULT_KEY=`jq .keys[0] vault.json`
VAULT_K64=`jq .keys_base64[0] vault.json`
VAULT_ROOT_TOKEN=`jq .root_token vault.json`

curl -k --request POST \
   --header "Content-Type: application/json" \
   --data "{\"key\": "$VAULT_KEY"}" \
   --url $VAULT_ADDR/v1/sys/unseal

docker exec -ti vault bash -c """vault login $VAULT_ROOT_TOKEN ;
   vault secrets enable -path=vault kv-v2 ;

   vault kv put vault/vault_key vault_key=${VAULT_KEY} ;
   vault kv put vault/vault_key64 vault_key64=${VAULT_K64} ;
   vault kv put vault/vault_root_token vault_root_token=${VAULT_ROOT_TOKEN}
   """