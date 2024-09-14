#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

kubectl apply -f "$SCRIPT_DIR/namespace.yaml"

helm upgrade -i \
  --namespace monitoring \
  tempo grafana/tempo \
  --values "$SCRIPT_DIR/values.yaml"

kubectl rollout status \
  --namespace monitoring \
  statefulset tempo --timeout=60s

kubectl apply -f "$SCRIPT_DIR/opentelemetry-plugin.yaml"