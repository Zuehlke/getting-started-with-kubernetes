# Helm Prometheus
[⬅️ Back to Kubernetes overview](README.md)

This is an example of a very complex Helm chart.

Add the prometheus helm repository locally. Similar to a docker registry. 
```shell
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```
💡 Helm does support reading/writing Helm charts to an OCI registry. 

Search a specific helm repo
```shell
helm search repo prometheus-community
```

## Install

Install a Helm chart with its latest version under the release name kps.
```shell
helm upgrade --install kps prometheus-community/kube-prometheus-stack -n monitoring --create-namespace --set prometheus-node-exporter.hostRootFsMount.enabled=false
```
Inspect/see customized installation notes

See all pods related to the just installed Helm chart
```shell
kubectl -n monitoring get pods -l "release=kps"
```

## Explore installed Helm chart

Foward port of the Grafana service to a local port
```shell
kubectl -n monitoring port-forward service/kps-grafana 8888:80
```
Now open http://localhost:8888 in the browser

What?! It needs credentials... but I dont have any...
List all Secret in the monitoring namespace
```shell
kubectl -n monitoring get secrets
```

Get the content of the Grafana secret
```shell
kubectl -n monitoring get secret kps-grafana -o yaml
```

What is this gibberish content? That does not work!?
You need to decode the values with base64

📝 Access Grafana with the credentials and explore the dashboards.

Inspect the installed resources
```shell
kubectl -n monitoring get all
```
See examples of Deployment, DaemonSets and StatefulSets. What are their purpose again?
But wait. Is this really all? Shouldn't there be some Secrets and ConfigMaps?
```shell
kubectl -n monitoring get configmap
kubectl -n monitoring get secret
```

## Uninstall

```shell
helm uninstall kps -n monitoring
```
```shell
kubectl delete namespace monitoring
```

## Exercise
You can go ahead and also integrate the logs into grafana with Loki & Promtail. After that you have a full monitoring 
stack installed in your Kubernetes cluster.
* For Loki you can use https://artifacthub.io/packages/helm/grafana/loki

  To install Loki you can use the following values:
  ```yaml
  loki:
    auth_enabled: false
    commonConfig:
      replication_factor: 1
    storage:
      type: 'filesystem'
    
  test:
    enabled: false
        
  monitoring:
    selfMonitoring:
      enabled: false
    lokiCanary:
      enabled: false
  ```
* For Promtail you can use https://artifacthub.io/packages/helm/grafana/promtail 
* Configure Loki as a new datasource in Grafana (use `http://loki:3100` as the url for the Loki datasource).
