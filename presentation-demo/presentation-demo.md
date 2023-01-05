# Presentation Demo

This directory contains the Kubernetes resources for the demo during the presentation.

- [Namespace](namespace) - Definition of the demo namespace
- [Pod](pod) - Resource to deploy a single pod
- [Deployment](deployment) - Deployment of a simple application
- [Probes](probes) - Different probes for the Pods
- [Services](svc) - Different types of Services

The namespaces for the demo can be created with the file [namespace.yaml](namespace/namespace.yaml)
```shell
kubectl apply -f ./namespace/namespace.yaml
```
Verify that the namespace was created
```shell
kubectl get namespace
```

## Complete example for the presentation

The complete example for the demo during the presentation can be found in the file [full.yaml](full.yaml)
