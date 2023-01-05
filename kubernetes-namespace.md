# Namespace
[⬅️ Back to Kubernetes overview](README.md)

Explain namespaces, what is their use?
Different environments: namespace vs. clusters

Create namespace
```shell
kubectl get namespace
kubectl create namespace test-env
```
📝 How many namespaces do you currently have on your system?

Create pod with same name in new namespace
```shell
kubectl run web --image nginx --port 80
kubectl run web --image nginx --port 80 --namespace test-env
```

Listing resources for specific namespaces
```shell
kubectl get pods
kubectl get pods --namespace=test-env
kubectl get pods --all-namespaces
```

Delete the created resources
```shell
kubectl delete namespace test-env
kubectl delete pod web
```