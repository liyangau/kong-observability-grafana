#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

kubectl apply -f "$SCRIPT_DIR/namespace.yaml"

helm upgrade -i \
  --namespace monitoring \
  loki grafana/loki \
  --values "$SCRIPT_DIR/values.yaml"
