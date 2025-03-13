# Deployments
[⬅️ Back to Kubernetes overview](README.md)

Create a deployment with httpd
```shell
oc create deployment --image=ubi8/httpd-24 httpd 
```

So what is the difference? There is still a pod, but with a weird name
```shell
oc get pod
oc describe pod httpd-7769f8f85b-5wcxt # replace the pod name with yours!
```

Pod is "Controlled By" a ReplicaSet
```shell
oc get replicaset
oc describe replicaset httpd-7769f8f85b # replace the replicaset name with yours!
```

ReplicaSet is "Controlled By" the Deployment we've just created
```shell
oc get deployment
oc describe deployment httpd # this is the name we explicitly supplied during creation of the deployment
```

Labels are properties attached to each object. Selectors filter these items and can help you typing or even remembering the automatically generated resource names.
```shell
oc get pods --selector app=httpd
# the short version:
oc get pods -l app=httpd
```

Let's scale the deployment to more instances and watch what happens
```shell
oc get pods --watch --output wide
oc scale deployment httpd --replicas=2
```

See the new pods? What happens if we delete an existing pod?
```shell
oc delete pod -l "app=httpd"
```

To see some more results in the rollout handling afterwards, we are changing the image to an older version.
```shell
oc set image deployment httpd httpd-24=ubi8/httpd-24:1-340
```

Check current pods
```shell
oc get pods
```

Delete the created resources
```shell
oc delete deployment httpd
```

## Exercise
* Create a new deployment with the Apache Webserver (httpd) and two replicas.
* Change the version and apply the new deployment, monitor the pod, resource & deployment resources.
* Restore the previous version of the deployment
