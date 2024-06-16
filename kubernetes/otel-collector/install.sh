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
  opentelemetry-operator open-telemetry/opentelemetry-operator \
  --values "$SCRIPT_DIR/operator-values.yaml"

kubectl rollout status \
  --namespace monitoring \
  deployment opentelemetry-operator --timeout=60s

kubectl apply -f "$SCRIPT_DIR/clusterrole.yaml"
kubectl apply -f "$SCRIPT_DIR/clusterrolebinding.yaml"
apply_crd_with_retries "$SCRIPT_DIR/otel-collector.yaml"
# kubectl apply -f "$SCRIPT_DIR/otel-collector.yaml"