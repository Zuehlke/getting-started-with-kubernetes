# Service
[⬅️ Back to Kubernetes overview](README.md)

Create a deployment with httpd

```shell
oc create deployment --image=ubi8/httpd-24 httpd 
```

Verify the deployment:
```sh
oc get deployments
oc get pods
```


## Using Different Types of Services

### ClusterIP

The `ClusterIP` service is the default type. It exposes the service on a cluster-internal IP, which means the service is accessible only within the cluster.


#### Create a ClusterIP Service:

```shell
oc expose deployment httpd --name=httpd-clusterip --port=80 --target-port=8080 --type=ClusterIP
```

#### Verify the ClusterIP Service:

```shell
oc get service httpd-clusterip
oc port-forward services/httpd-clusterip 12380:80
# In another terminal window 
curl localhost:12380 # or open localhost:12380 in your browser
```

You should see an internal IP assigned to the service. Pods within the cluster can communicate with the service using this IP. When port-forwarding you should be able to access the httpd server.

### Scaling 

Now that you've created your service, the deployment which it points to can be scaled without any interuption to the user. The service selects one of the pods to forward to.

Scale your service:
```shell
oc scale deployment httpd --replicas 2
```
_When portforwarding oc chooses one pod to forward traffic to._

### NodePort

The `NodePort` service exposes the service on each Node's IP at a static port. This allows external access to the service on `<NodeIP>:<NodePort>`.

#### Create a NodePort Service:

```shell

oc expose deployment httpd --name=httpd-nodeport --port=80 --target-port=8080 --type=NodePort
```

#### Verify the NodePort Service:

```shell
oc get service httpd-nodeport
```

You should see a port in the range of 30000-32767. You can now access the service using `<NodeIP>:<NodePort>`.

Depending on your local enviromnent or cloud env you should now be able to access your service with the nodes ip address and the nodeport.

_when running locally this wont work with all local clusters types_ 


###  ExternalName


The `ExternalName` service maps a service to the contents of an external DNS name. This type of service does not create a proxy and is mainly used to redirect internal traffic to an external domain.


#### Create an ExternalName Service:

```shell
oc create service externalname httpd-externalname --external-name=example.com
```

#### Verify the ExternalName Service:


```shell
oc get service httpd-externalname
```


The service redirects any requests to `httpd-externalname` to `example.com`. This service is mainly useful for accessing external services with a DNS name.


## Exercise 

* Create a new deployment with the Apache Webserver (httpd) and two replicas.
* Create a service to access the Apache Webserver via the browser. If you are using a managed Kubernetes cluster in the cloud, please use the Service type **LoadBalancer**.


## Further Resources
[Kubernetes Service Documentation ](https://kubernetes.io/docs/concepts/services-networking/service/)
