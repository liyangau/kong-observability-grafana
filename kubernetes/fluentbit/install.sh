#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

kubectl apply -f "$SCRIPT_DIR/namespace.yaml"

helm upgrade -i \
  --namespace monitoring \
  fluent-bit fluent/fluent-bit \
  --values "$SCRIPT_DIR/values.yaml"

kubectl apply -f "$SCRIPT_DIR/http-log-plugin.yaml"