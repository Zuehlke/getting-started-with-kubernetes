# Service
[⬅️ Back to Kubernetes overview](README.md)

Create a deployment with nginx

```shell
kubectl create deployment --image=nginx --port 80 nginx 
```

Verify the deployment:
```sh
kubectl get deployments
kubectl get pods
```


## Using Different Types of Services

### a) ClusterIP (Default)

The `ClusterIP` service is the default type. It exposes the service on a cluster-internal IP, which means the service is accessible only within the cluster.


#### Create a ClusterIP Service:

```shell
kubectl expose deployment nginx --name=nginx-clusterip --port=80 --target-port=80 --type=ClusterIP
```

#### Verify the ClusterIP Service:

```shell
kubectl get service nginx-clusterip
```


You should see an internal IP assigned to the service. Pods within the cluster can communicate with the service using this IP.

### b) NodePort

The `NodePort` service exposes the service on each Node's IP at a static port. This allows external access to the service on `<NodeIP>:<NodePort>`.

#### Create a NodePort Service:

```shell

kubectl expose deployment nginx --name=nginx-nodeport --port=80 --target-port=80 --type=NodePort
```

#### Verify the NodePort Service:

```shell
kubectl get service nginx-nodeport
```

You should see a port in the range of 30000-32767. You can now access the service using `<NodeIP>:<NodePort>`.

### c) LoadBalancer

The `LoadBalancer` service exposes the service externally using a cloud provider's load balancer. It provisions a load balancer in supported cloud environments (e.g., AWS, GCP).

#### Create a LoadBalancer Service:


```shell
kubectl expose deployment nginx --name=nginx-loadbalancer --port=80 --target-port=80 --type=LoadBalancer
```

#### Verify the LoadBalancer Service:


```shell
kubectl get service nginx-loadbalancer
```

In cloud environments, you will see an external IP assigned to the service. You can access the service using this external IP.

> **Note:** If you're running Kubernetes locally (e.g., minikube or kind), you might not see an external IP. Instead, you can use `minikube service nginx-loadbalancer` to access the service.

### d) ExternalName


The `ExternalName` service maps a service to the contents of an external DNS name. This type of service does not create a proxy and is mainly used to redirect internal traffic to an external domain.


#### Create an ExternalName Service:

```shell
kubectl create service externalname nginx-externalname --external-name=example.com
```

#### Verify the ExternalName Service:


```shell
kubectl get service nginx-externalname
```


The service redirects any requests to `nginx-externalname` to `example.com`. This service is mainly useful for accessing external services with a DNS name.


## Exercise 

* Create a new deployment with the Apache Webserver (httpd) and two replicas.
* Create a service to access access the Apache Webserver via the browser


