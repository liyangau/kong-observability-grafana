#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

kubectl apply -f "$SCRIPT_DIR/namespace.yaml"

helm upgrade -i \
  cert-manager jetstack/cert-manager \
  --version v1.16.1 \
  --namespace cert-manager \
  --set crds.enabled=true \
  --set config.enableGatewayAPI=true