#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

kubectl apply -f "$SCRIPT_DIR/namespace.yaml"

helm upgrade -i \
  --namespace monitoring \
  --version v6.25.0 \
  loki grafana/loki \
  --values "$SCRIPT_DIR/values.yaml"
