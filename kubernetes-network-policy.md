# Network Policy
[⬅️ Back to Kubernetes overview](README.md)

Create a deployment with nginx in your namespace
```shell
kubectl create deployment --image=nginx nginx 
```

Obtain the created pod name by running the following command:
````
kubectl get po
````

## Allow all egress from a namespace
Currently the K8s cluster does not have a network policy with an restriction in place. To start developing an egress network policy for your namespace let's start with a network policy that allows all egress communication. 

You can use the file [network-policy-egress-allow-all.yaml](kubernetes/security-policy/network-policy-egress-allow-all.yaml) to create the deployment.
Replace the `<namespace>` placeholder with the name of your namespace and run the following command:

````
kubectl apply -f kubernetes/security-policy/network-policy-egress-allow-all.yaml -n <namespace>
````

Now, open a shell in the nginx pod. Replace `nginx-bf5d5cf98-mnzp2` with the name of your pod.
````
kubectl exec -it nginx-bf5d5cf98-mnzp2 -- bash
````

Inside the pod verfy that you can access external services, such as https://kubernetes.io using a tool such as `curl`:

````
curl -v kubernetes.io
````

Verify that you can also access internal services, such as http://console.platform:
````
curl -v console.platform
````

## Allow no egress from a namespace
Let's change the network policy to deny all egress traffic from the namespace by replacing the previous policy with the policy [network-policy-egress-deny-all.yaml](kubernetes/security-policy/network-policy-egress-deny-all.yaml)

````
kubectl apply -f kubernetes/security-policy/network-policy-egress-deny-all.yaml -n <namespace>
````

Again, you can check the access to external and internal services from inside the pod:

````
curl -v kubernetes.io
curl -v console.platform
````

Access to both endpoints should no longer be possible.

## Allow egress to an external IP from a namespace
Let's create a new policy that enables egress connection to a single IP address (e.g. 147.75.40.148, which is the current IP for kubernetes.io). For this apply the following policy: [network-policy-egress-allow-ip-block.yaml](kubernetes/security-policy/network-policy-egress-allow-ip-block.yaml)

````
kubectl apply -f kubernetes/security-policy/network-policy-egress-allow-ip-block.yaml -n <namespace>
````

Check the access to the external IP from inside the pod:

````
curl -v 147.75.40.148
````
You should now have access to this single IP address.

## Allow egress DNS queries from a namespace

Blocking all egress traffic except for one IP means that also DNS requests are glocked. You can enable DNS requests by creating a new network policy that allows UPD traffic on port 53 to the cluster DNS: [network-policy-egress-allow-dns.yaml](kubernetes/security-policy/network-policy-egress-allow-dns.yaml)

````
kubectl apply -f kubernetes/security-policy/network-policy-egress-allow-dns.yaml -n <namespace>
````

Check that DNS names can be resolved from inside the pod:

````
curl -v kubernetes.io
````
You should now have be able to access kubernetes.io by its domain name instead of its IP.

## Allow all egress to another namespace

Egress to other namespaces also requires a network policy. To enable any network access to the 'platform' namespace you can create the following policy: 
[network-policy-egress-allow-namespace.yaml](kubernetes/security-policy/network-policy-egress-allow-namespace.yaml)

````
kubectl apply -f kubernetes/security-policy/network-policy-egress-allow-namespace.yaml -n <namespace>
````
You should now be able to verify the successful connectivty with the following command form inside the pod:
````
curl -v console.platform
````

## Experiment with network policies

To experiment with network policies you can also create a generic pod and use tools like curl, netcat, nslookup. 

E.g., start an ubuntu image and connect to the shell:
````
kubectl run -i  --tty ubuntu --image=ubuntu -- bash
````

Additional packages, such as `curl` can be installed by running
````
apt update
apt install curl
````

If you disconnect from the shell you can reconnect again with the following commend:
````
kubectl exec --stdin --tty ubuntu -- bash
````


## Further Reading
[Kubernetes Network Policy Documentation](https://kubernetes.io/docs/concepts/services-networking/network-policies/)

