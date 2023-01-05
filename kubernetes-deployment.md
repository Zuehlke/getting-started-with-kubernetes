# Deployments
[⬅️ Back to Kubernetes overview](README.md)

Create a deployment with nginx
```shell
kubectl create deployment --image=nginx --port 80 nginx 
```

So what is the difference? There is still a pod, but with a weird name
```shell
kubectl get pod
kubectl describe pod -l "app=nginx"
```

Pod is "Controlled By" a ReplicaSet
```shell
kubectl get replicaset
kubectl describe replicaset -l "app=nginx"
```

ReplicaSet is "Controlled By" the Deployment we've just created
```shell
kubectl get deployment
kubectl describe deployment nginx
```

Labels are properties attached to each object. Selectors filter these items.
```shell
kubectl get pods --selector app=nginx
```

Expose the deployment using a `Service` of type `NodePort`
```shell
kubectl create service nodeport nginx --tcp 80:80
```

Try to find the `NodePort` for your service.
```shell
kubectl describe service nginx
```

Visit `http://localhost:<nodeport>/` to view your deployment.

💡 `NodePort`s can only be in the range of 30000-32767

How does this even know to what pod to route the traffic to? Let's inspect the created service
```shell
kubectl get service
kubectl get service nginx  -o yaml
```

Let's scale the deployment to more instances and watch what happens
```shell
kubectl get pods --watch --output wide
kubectl scale deployment nginx --replicas=2
```

See the new pods? What happens if we delete an existing pod?
```shell
kubectl delete pod -l "app=nginx"
```

To see some more results in the rollout handling afterwards, we are changing the image to an older version.
```shell
kubectl set image deployment nginx nginx=nginx:1.20.2
```

Check current pods
```shell
kubectl get pods
```

Delete the created resources
```shell
kubectl delete service nginx
kubectl delete deployment nginx
```

## Exercise
* Create a new deployment with the Apache Webserver (httpd) and two replicas.
* Expose a node port service with port 30081
