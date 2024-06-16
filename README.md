# Kong observability with Grafana

This repo demonstrate how to config [Kong](https://github.com/Kong/kong) to ship logs, metrics and traces to different backend and use grafana as the dashboard to visulise the data.

The solution 

![](assets/kong-observability-solution-grafana.png)

**Backend**
- Logs -> Loki
- Metrics -> Prometheus
- Traces -> Jaeger


**App**
- [fluentbit](https://www.fluentbit.io/)
- Httpbin
- [Hotrod](https://github.com/jaegertracing/jaeger/tree/main/examples/hotrod)

Detail explaination can be found on this [blog post](https://tech.aufomm.com/kong-observability-with-grafana-a-unified-view-for-logs-metrics-and-traces).