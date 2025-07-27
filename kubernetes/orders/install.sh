#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
kubectl apply -f "$SCRIPT_DIR/namespace.yaml"
kubectl apply -f "$SCRIPT_DIR/auto-instrumentation.yaml"
kubectl apply -f "$SCRIPT_DIR/deployments.yaml"
kubectl apply -f "$SCRIPT_DIR/services.yaml"
kubectl apply -f "$SCRIPT_DIR/httproute.yaml"