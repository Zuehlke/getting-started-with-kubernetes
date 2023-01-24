# API
[⬅️ Back to Kubernetes overview](README.md)

Structure, API / Kind
Most frequently used resources: Deployment, Service, ConfigMap, Secret
```shell
kubectl api-resources
```
💡 Use short names to save time typing

📝 Which of the API versions occurs most often?

Inspect Kubernetes resources
```shell
kubectl explain
kubectl explain deployment.spec.replicas
kubectl explain deployment.spec.selector --recursive
```
Also see https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.23/

📝 Can get more information about the field `nodeName` for a `Pod` specification?

Access the API natively without having to fiddle with authentication
```shell
kubectl proxy
curl http://localhost:8001/
curl http://localhost:8001/api/v1/pods
```

Check out the OpenAPI spec of your cluster
```shell
curl http://localhost:8001/openapi/v2
```
Can load it into any OpenAPI browser like https://editor.swagger.io/ (might be slow, does not allow mixing http/https so go via file)
```shell
curl http://localhost:8001/openapi/v2 -o k8s-api.yaml
```


