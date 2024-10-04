# Deployments
[⬅️ Back to Kubernetes overview](README.md)

Create a deployment with nginx
```shell
kubectl create deployment --image=nginx --port 80 nginx 
```

So what is the difference? There is still a pod, but with a weird name
```shell
kubectl get pod
kubectl describe pod nginx-7769f8f85b-5wcxt # replace the pod name with yours!
```

Pod is "Controlled By" a ReplicaSet
```shell
kubectl get replicaset
kubectl describe replicaset nginx-7769f8f85b # replace the replicaset name with yours!
```

ReplicaSet is "Controlled By" the Deployment we've just created
```shell
kubectl get deployment
kubectl describe deployment nginx # this is the name we explicitly supplied during creation of the deployment
```

Labels are properties attached to each object. Selectors filter these items and can help you typing or even remembering the automatically generated resource names.
```shell
kubectl get pods --selector app=nginx
# the short version:
kubectl get pods -l app=nginx
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
kubectl delete deployment nginx
```

## Exercise
* Create a new deployment with the Apache Webserver (httpd) and two replicas.
* Change the version and apply the new deployment, monitor the pod, resource & deployment resources.
* Restore the previous version of the deployment