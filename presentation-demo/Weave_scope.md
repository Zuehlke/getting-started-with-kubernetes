# Weave Scope
Install Weave scope
```shell
kubectl apply -f https://github.com/weaveworks/scope/releases/download/v1.13.2/k8s-scope.yaml
```
Port forward the UI port
```shell
kubectl port-forward svc/weave-scope-app -n weave 4040:80
```
Browse to http://localhost:4040 and have a look at the ui