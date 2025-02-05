#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

kubectl apply -f "$SCRIPT_DIR/namespace.yaml"

helm upgrade -i \
  tempo grafana/tempo \
  --namespace monitoring \
  --version v1.18.1 \
  --values "$SCRIPT_DIR/values.yaml"

kubectl rollout status \
  --namespace monitoring \
  statefulset tempo --timeout=60s

kubectl apply -f "$SCRIPT_DIR/opentelemetry-plugin.yaml"