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

Forward the service installed by helm and open it in your browser:
```
kubectl port-forward service/hello-kubernetes-my-hello-kubernetes 8888:80
```

## Explore installed Helm chart

```shell
kubectl port-forward service/hello-kubernetes-my-hello-kubernetes 8008:80
```

What if you want to configure the Helm chart? Surely the default config is not what you were looking for..

Let's set a custom message:
```shell
helm upgrade my-hello-kubernetes opsmx/hello-kubernetes --set 'message=I was here'
```

For better maintainability and particularly if you have more than one simple message:
```shell
echo "message: I think you are going too fast ... ️🤯️" > values-message.yaml
helm upgrade my-hello-kubernetes opsmx/hello-kubernetes --values values-message.yaml
```

💡 Multiple `values.yaml` files can be provided to a Helm installation


Explore the chart on https://artifacthub.io/packages/helm/opsmx/hello-kubernetes or locally:
```shell
helm pull opsmx/hello-kubernetes --version 1.0.3 --untar
```

The chart should be available in the file `hello-kubernetes-1.0.3.tgz` as well as unpacked in the directory `hello-kubernetes`

## Helm charts structure

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
