#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

print_message() {
  echo "############################################################"
  echo "#"
  echo "#  $1"
  echo "#"
  echo "############################################################"
}

# Adding Helm repositories
print_message "Adding Helm repositories..."

helm repo add jetstack https://charts.jetstack.io
helm repo add kong https://charts.konghq.com
helm repo add fluent https://fluent.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Array of applications and their installation scripts in the desired order
apps=(
  "Kong:$SCRIPT_DIR/kong/install.sh"
  "cert-manager:$SCRIPT_DIR/cert-manager/install.sh"
  "fluentbit:$SCRIPT_DIR/fluentbit/install.sh"
  "Opentelemetry Collector:$SCRIPT_DIR/otel-collector/install.sh"
  "Loki:$SCRIPT_DIR/loki/install.sh"
  "Grafana:$SCRIPT_DIR/grafana/install.sh"
  "Prometheus:$SCRIPT_DIR/prometheus/install.sh"
  "Jaeger:$SCRIPT_DIR/jaeger/install.sh"
  "App hotrod:$SCRIPT_DIR/hotrod/install.sh"
  "App httpbin:$SCRIPT_DIR/httpbin/install.sh"
)

# Iterate through the applications array and install each one in order
for app in "${apps[@]}"; do
  app_name="${app%%:*}"
  app_script="${app##*:}"
  print_message "Installing $app_name..."
  sh "$app_script"
done