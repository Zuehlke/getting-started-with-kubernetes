# ResourceQuota

[⬅️ Back to Kubernetes overview](README.md)

Create a ResourceQuota with limits
```shell
kubectl create quota my-quota --hard=cpu=1,memory=1G
```

View the created ResourceQuota
```shell
kubectl describe quota my-quota
```

Now create a deployment with resource limits.
You can use the file [deployment.yaml](kubernetes/quota/deployment.yaml) to create the deployment.
```shell
kubectl apply -f kubernetes/quota/deployment.yaml
```

Now view the created ResourceQuota again

Now it's time to scale the deployment (So that we use more resources)
```shell
kubectl scale deploy webserver-quota --replicas 11
```

📝 With how many pods did you end up? How can you explain this?

Let's have a look at the replicaset
```shell
kubectl get rs -l app=webserver-quota
kubectl describe rs -l app=webserver-quota
```

📝 What is the exact reason that not all pods can be created?


Delete the resoruce that where created
```shell
kubectl delete deploy webserver-quota
kubectl delete quota my-quota
```

## Exercise
* Try to limit other types than cpu & memory resources
