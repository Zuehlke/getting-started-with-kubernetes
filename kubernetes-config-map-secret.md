# Environment variables, ConfigMaps & Secrets
[⬅️ Back to Kubernetes overview](README.md)

# Environment variables, ConfigMaps & Secrets

Inspect and apply the template "hello-kubernetes" example under `kubernetes/hello-kubernetes/resources.yaml`
```shell
kubectl apply -f kubernetes/hello-kubernetes/resources.yaml
```

Create a port-forwarding for the service so you can access it at [localhost:8000](http://localhost:8000):
```shell
kubectl port-forward svc/hello-kubernetes 8000:8000
```

Let's externalize the message into an external configuration using a `ConfigMap`
```shell
kubectl create configmap hello-message --from-literal="message=👋 Hello from the ConfigMap"
kubectl get configmap
kubectl get configmap hello-message -o yaml
```

📝 This `ConfigMap` is now created imperatively. How could we make it declarative and manage it with the other resources?

Replace the environment variable definition with a lookup to the `ConfigMap` in the exisiting yaml `kubernetes/hello-kubernetes/resources.yaml`.
```yaml
          - name: MESSAGE
            valueFrom:
              configMapKeyRef:
                name: hello-message
                key: message
```

Apply the resources again
```shell
kubectl apply -f kubernetes/hello-kubernetes/resources.yaml
```

You might need to recreate the port-forwarding to check [localhost:8000](http://localhost:8000):

```shell
kubectl port-forward svc/hello-kubernetes 8000:8000
```

📝 Did the pods restart to show this change? Why (not)?

Let's update the value in the `ConfigMap` (Can also be done declaratively if part of the resource)
```shell
kubectl edit configmap hello-message
```

Let's check the result at [localhost:8000](http://localhost:8000) - you might need to recreate the port-forwarding:

```shell
kubectl port-forward svc/hello-kubernetes 8000:8000
```

📝 Can you explain the result?

The environment inside the container can also be checked. Note: the `Pod` name will certainly be different
```shell
kubectl exec -it hello-kubernetes-59bb8ffc5f-gvlbq -- env
kubectl exec -it hello-kubernetes-59bb8ffc5f-gvlbq -- env | grep MESSAGE
```

💡 If you're stuck and need a hint or a reference, there is also a prepared version with a `ConfigMap` under `kubernetes/hello-kubernetes/resources-configmap.yaml`. It provides a service named `config-app` and can be port-forwarded.

📝 What can we do?

If we want to "protect" the values of externalized configuration, we can use `Secrets`
```shell
kubectl create secret generic secret-message --from-literal="message=🤫 ... this is a secret message"
kubectl get secret
kubectl get secret secret-message -o yaml
```

Looks safe, doesn't it?

Let's use it instead of the `ConfigMap` in your resource file, probably either `resources.yaml` or `resources-configmap.yaml`.
```yaml
          - name: MESSAGE
            valueFrom:
              secretKeyRef:
                name: secret-message
                key: message
```
Apply the resources again
```shell
kubectl apply -f <your resource file.yaml> 
```

Make sure the port-forward is still up and check the application at [localhost:8000](http://localhost:8000).

💡 As a reference, there is also a prepared version with a `Secret` under `kubernetes/hello-kubernetes/resource-secret.yaml`. Its service is called `secrets-app`.
