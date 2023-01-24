# Helm Basics
[⬅️ Back to Kubernetes overview](README.md)

Add the opsmx helm repository locally. Similar to a docker registry. 
```shell
helm repo add opsmx https://helmcharts.opsmx.com/
```
💡 Helm does support reading/writing Helm charts to an OCI registry. 

Search repositories for a keyword in charts. E.g. find `hello-kubernetes`. 
```shell
helm search repo hello-kubernetes
```

## Alternative for MAC:

Add the sikalabs helm repository locally. Similar to a docker registry. 
```shell
helm repo add sikalabs https://helm.sikalabs.io
```
💡 Helm does support reading/writing Helm charts to an OCI registry. 

Search repositories for a keyword in charts. E.g. find `hello-world`. 
```shell
helm search repo hello-world
```

## Install Windows

Install a Helm chart with its latest version under the **release name** `my-hello-kubernetes`
```shell
helm install my-hello-kubernetes opsmx/hello-kubernetes
```
List your release with the following command.
```shell
helm ls
```

See everything related to the just installed Helm chart based on your releae name.
```shell
kubectl get all -l "app.kubernetes.io/instance=my-hello-kubernetes"
```

## Install Mac

Install a Helm chart with its latest version under the **release name** `my-hello-world`
```shell
helm install my-hello-world sikalabs/hello-world --version 0.4.0
```
List your release with the following command.
```shell
helm ls
```
Watch the result in your Browser
```
kubectl port-forward service/my-hello-world 8888:80
```

Update a value file and make Helm aware of it. 
```
echo "TEXT: New Text." > values-message.yaml
helm upgrade my-hello-world sikalabs/hello-world --values values-message.yaml
```
📝 Check the result again

## Explore installed Helm chart Windows

Foward port of the Grafana service to a local port
```shell
kubectl port-forward service/hello-kubernetes-my-hello-kubernetes 8008:80
```

Where does Helm store its data?
```shell
kubectl get secret sh.helm.release.v1.my-hello-kubernetes.v1
kubectl get secret sh.helm.release.v1.my-hello-kubernetes.v1 -o yaml
```

What if you want to configure the Helm chart? Surely the default config is not what you were looking for..

Let's set a custom message
```shell
helm upgrade my-hello-kubernetes opsmx/hello-kubernetes --set 'message=I was here'
```

```shell
echo "message: I think you are going too fast ... ️🤯️" > values-message.yaml
helm upgrade my-hello-kubernetes opsmx/hello-kubernetes --values values-message.yaml
```
💡 Multiple `values.yaml` files can be provided to a Helm installation


Explore the chart on https://artifacthub.io/packages/helm/opsmx/hello-kubernetes or locally
```shell
helm pull opsmx/hello-kubernetes --version 1.0.3 --untar
```
The chart should be available in the file `hello-kubernetes-1.0.3.tgz` as well as unpacked in the directory `hello-kubernetes`

## Helm charts structure Windows

Explain anatomy of Helm CLI
```shell
helm help
```

A few tricks when working with Helm charts
List description/info for a chart
```shell
helm show chart opsmx/hello-kubernetes
```
List all (default) values for a chart.
```shell
helm show values opsmx/hello-kubernetes
```
https://artifacthub.io/ is where a lot of charts and also documentation can be found. 
A lot of different charts already exist, obviously. 

💡 For good charts apart from official ones (if available) are the Bitnami ones: https://artifacthub.io/packages/search?kind=0&org=bitnami

## Uninstall

```shell
helm uninstall my-hello-kubernetes
```

💡 Alternative to Helm: [kustomize](https://kustomize.io/) 
