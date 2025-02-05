#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

kubectl apply -f "$SCRIPT_DIR/namespace.yaml"

helm upgrade -i \
  minio-operator minio-operator/operator \
  --namespace monitoring \
  --version v7.0.0 \
  --values "$SCRIPT_DIR/operator-values.yaml"

kubectl rollout status \
  -n monitoring deployment \
  minio-operator --timeout=60s

helm upgrade -i \
  minio-tenant minio-operator/tenant \
  --namespace monitoring \
  --version v7.0.0 \
  --values "$SCRIPT_DIR/tenant-values.yaml"