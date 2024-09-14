#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

kubectl apply -f "$SCRIPT_DIR/namespace.yaml"

helm upgrade -i \
  --namespace monitoring \
  minio-operator minio-operator/operator \
  --values "$SCRIPT_DIR/operator-values.yaml"

kubectl rollout status \
  -n monitoring deployment \
  minio-operator --timeout=60s

helm upgrade -i \
  --namespace monitoring \
  minio-tenant minio-operator/tenant \
  --values "$SCRIPT_DIR/tenant-values.yaml"