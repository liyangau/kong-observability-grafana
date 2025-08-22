#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

kubectl apply -f "$SCRIPT_DIR/namespace.yaml"
kubectl apply -f \
  https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/standard-install.yaml
kubectl apply -f "$SCRIPT_DIR/gatewayclass.yaml"
kubectl apply -f "$SCRIPT_DIR/gateway.yaml"
helm upgrade -i kong kong/ingress -n kong --values "$SCRIPT_DIR/values.yaml" --version v0.17.0
kubectl apply -f "$SCRIPT_DIR/opentelemetry-plugin.yaml"

if [[ -n $KONG_LICENSE_DATA ]];then
  envsubst < "$SCRIPT_DIR/license.yaml" | kubectl apply -f -
fi