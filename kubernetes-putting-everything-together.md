# Putting everything together 
![end goal](kubernetes/end-goal.png)

### Tasks

- Create a Deployment of an Apache webserver consisting of two Pods.
- Add a Liveness probe for the Apache webserver deployment. See the [example](presentation-demo/probes/probe_liveness.yaml)from the presentation demo.
- Deploy your app in a dedicated Namespace (not in the default Namespace).

---


#### Optional: Store the website on a PersistentVolume

Store the website on a PersistentVolume shared by the Pods of the Deployment. The Apache webserver serves content from `/usr/local/apache2/htdocs/`.

💡 `kubectl cp` cna be used to copy files to containers.

💡 Use `kubectl cp -h` for help & examples on how to use it.



#### Optional: Ingress

- Create a ClusterIP Service for the apache webserver deployment
- Create an ingress pointing to the service. Consult the [ingress guide](./kubernetes-ingress.md) for help.

