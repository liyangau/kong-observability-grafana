# Kong observability with Grafana

This repo demonstrate how to config [Kong](https://github.com/Kong/kong) to ship logs, metrics and traces to different backend and use grafana as the dashboard to visulise the data.

The solution 

![](assets/kong-observability-solution-grafana.png)

**Backend**
- Logs -> Loki
- Metrics -> Prometheus
- Traces -> Tempo

**App**
- [fluentbit](https://www.fluentbit.io/)
- Httpbin
- [Hotrod](https://github.com/jaegertracing/jaeger/tree/main/examples/hotrod)

### Kubernetes

Inside the `kubernetes/` folder, run `./install.sh` to deploy everything for you.

- Kong is also running in dbless mode with Kong ingress controller with Gateway API enabled.
- The script detects environment variable `KONG_LICENSE_DATA` and reates a `KongLicence` object accordingly.
- I have to create `clusterrole` and `clusterrolebinding` for opentelemetry collector to scrape the Kong pod. If you have a better solution, please submit your PR.
- Grafana dashboard password is also disabled. Please remove the `env` section of [values.yaml](https://github.com/liyangau/kong-observability-grafana/blob/main/kubernetes/grafana/values.yaml) if you need the log in page.

Detail explaination of the solution can be found on this [blog post](https://tech.aufomm.com/kong-observability-with-grafana-a-unified-view-for-logs-metrics-and-traces).
