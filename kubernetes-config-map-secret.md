# Environment variables, ConfigMaps & Secrets
[⬅️ Back to Kubernetes overview](README.md)

# Environment variables, ConfigMaps & Secrets

Inspect and apply the template "hello-kubernetes" example under `kubernetes/hello-kubernetes/resources.yaml`
```shell
kubectl apply -f kubernetes/hello-kubernetes/resources.yaml
```
Check the deployed app under http://localhost:31313

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

Let's check the result under http://localhost:31313

📝 Did the pods restart to show this change? Why (not)?

Let's update the value in the `ConfigMap` (Can also be done declaratively if part of the resource)
```shell
kubectl edit configmap hello-message
```

Let's check the result under http://localhost:31313

📝 Can you explain the result?

The environment inside the container can also be checked. Note: the `Pod` name will certainly be different
```shell
kubectl exec -it hello-kubernetes-59bb8ffc5f-gvlbq -- env
kubectl exec -it hello-kubernetes-59bb8ffc5f-gvlbq -- env | grep MESSAGE
```

💡 There is also a prepared version with a `ConfigMap` under `kubernetes/hello-kubernetes/resource-configmap.yaml`. It provides a service under http://localhost:31323

📝 What can we do?

If we want to "protect" the values of externalized configuration, we can use `Secrets`
```shell
kubectl create secret generic secret-message --from-literal="message=🤫 ... this is a secret message"
kubectl get secret
kubectl get secret secret-message -o yaml
```

Looks safe, doesn't it?

Let's use it instead of the `ConfigMap` in `kubernetes/hello-kubernetes/resource-configmap.yaml`.
```yaml
          - name: MESSAGE
            valueFrom:
              secretKeyRef:
                name: secret-message
                key: message
```
Apply the resources again
```shell
kubectl apply -f kubernetes/hello-kubernetes/resource-configmap.yaml
```

Let's check the result under http://localhost:31313

💡 There is also a prepared version with a `Secret` under `kubernetes/hello-kubernetes/resource-secret.yaml`. It provides a service under http://localhost:31333