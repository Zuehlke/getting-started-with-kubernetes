# Ingress
[⬅️ Back to Kubernetes overview](README.md)


## Setup ingress controller
![Ingress Controller](./kubernetes/ingress.png)

### When using kind:
1. Create Namespace

```sh
kubectl create namesapce ingress-nginx

```
2. Deploy Ingress Controller. [Github link](https://github.com/kubernetes/ingress-nginx)
```sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.0/deploy/static/provider/kind/deploy.yaml -n ingress-nginx
```
### When using Minikube
From the setup guide in the [Documentation](https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/) 

```sh
minikube addons enable ingress
```

## Setup applications 

1. Deploy a hello world app:
```sh
kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0
kubectl expose deployment web --type=NodePort --port=8080
kubectl expose deployment web2 --port=8080 --type=NodePort

```

## Create an Ingress 
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
spec:
  ingressClassName: nginx
  rules:
    - host: hello-world.example
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: web
                port:
                  number: 8080
```
Run `kubectl apply -f ingress.yaml` to create it.

To test on minikube:

```sh
curl --resolve "hello-world.example:80:$( minikube ip )" -i http://hello-world.example

```
## Create another deployment

```sh
kubectl create deployment web2 --image=gcr.io/google-samples/hello-app:2.0
kubectl expose deployment web2 --port=8080 --type=NodePort
```

create route for second service:

```yaml
- path: /v2
  pathType: Prefix
  backend:
    service:
      name: web2
      port:
        number: 8080
```

Run `kubectl apply -f ingress.yaml` to update it.
## Test the ingresses
```sh
curl --resolve "hello-world.example:80:$( minikube ip )" -i http://hello-world.example

## Output should be similar to:
# Hello, world!
# Version: 1.0.0
# Hostname: web-55b8c6998d-8k56

curl --resolve "hello-world.example:80:$( minikube ip )" -i http://hello-world.example/v2

## Output should be similar to:
# Hello, world!
# Version: 2.0.0
# Hostname: web-55b8c6998d-8k56


```

## Further Reading

- https://devopscube.com/kubernetes-ingress-tutorial/ 
- https://kubernetes.io/docs/concepts/services-networking/ingress/ 
- https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/
