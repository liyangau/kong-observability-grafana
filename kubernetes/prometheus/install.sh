#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

kubectl apply -f "$SCRIPT_DIR/namespace.yaml"

helm upgrade -i \
  prometheus prometheus-community/prometheus \
  --namespace monitoring \
  --values "$SCRIPT_DIR/values.yaml" 

kubectl apply -f "$SCRIPT_DIR/prometheus-plugin.yaml"
