#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

kubectl apply -f "$SCRIPT_DIR/namespace.yaml"

helm upgrade -i \
  fluent-bit fluent/fluent-bit \
  --namespace monitoring \
  --version v0.48.5 \
  --values "$SCRIPT_DIR/values.yaml"

kubectl apply -f "$SCRIPT_DIR/http-log-plugin.yaml"