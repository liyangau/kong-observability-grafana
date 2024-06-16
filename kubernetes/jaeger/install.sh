#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Function to apply a CRD with retries
apply_crd_with_retries() {
  local crd_file=$1
  local max_attempts=5
  local attempt=1
  local success=false

  until [ "$attempt" -gt "$max_attempts" ]; do
    kubectl apply -f "$crd_file" && success=true && break
    echo "Attempt $attempt/$max_attempts to apply CRD $crd_file failed. Retrying in 5 seconds..."
    sleep 5
    attempt=$(( attempt + 1 ))
  done

  if [ "$success" = false ]; then
    echo "Failed to apply CRD $crd_file after $max_attempts attempts."
    exit 1
  fi
}

kubectl apply -f "$SCRIPT_DIR/namespace.yaml"

helm upgrade -i \
  --namespace monitoring \
  jaeger-operator jaegertracing/jaeger-operator --version 2.53.0

kubectl rollout status \
  --namespace monitoring \
  deployment jaeger-operator --timeout=60s

apply_crd_with_retries "$SCRIPT_DIR/jaeger.yaml"

# kubectl apply -f "$SCRIPT_DIR/jaeger.yaml"
kubectl apply -f "$SCRIPT_DIR/opentelemetry-plugin.yaml"