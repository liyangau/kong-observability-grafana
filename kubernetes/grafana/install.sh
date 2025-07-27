#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

kubectl apply -f "$SCRIPT_DIR/namespace.yaml"
helm upgrade -i \
  grafana grafana/grafana \
  --namespace monitoring \
  --version v9.2.7 \
  --values "$SCRIPT_DIR/values.yaml"
