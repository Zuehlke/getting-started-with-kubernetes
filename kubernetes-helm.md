# Helm Basics
[⬅️ Back to Kubernetes overview](README.md)

Add the opsmx helm repository locally. Similar to a docker registry. 
```shell
helm repo add jhidalgo3-github https://jhidalgo3.github.io/helm-charts/
```
💡 Helm does support reading/writing Helm charts to an OCI registry. 

Search repositories for a keyword in charts. E.g. find `hello-kubernetes`. 
```shell
helm search repo hello-kubernetes
```

Install a Helm chart with its latest version under the **release name** `my-hello-kubernetes`
```shell
helm install my-hello-kubernetes jhidalgo3-github/hello-kubernetes-chart
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
 kubectl port-forward service/my-hello-kubernetes-hello-kubernetes-chart 8888:80
```

## Explore installed Helm chart

What if you want to configure the Helm chart? Surely the default config is not what you were looking for..

Let's set a custom message:
```shell
helm upgrade my-hello-kubernetes jhidalgo3-github/hello-kubernetes-chart --set 'configs.MESSAGE=I was here'
```

For better maintainability and particularly if you have more than one simple message:
```shell
echo -e "configs:\n  MESSAGE: I think you are going too fast ... ️🤯️" > values-message.yaml
```

"If you do not have the `echo` command, create a file that looks like this one.
```shell
    configs:
        MESSAGE: I think you are going too fast ... ️🤯️
```

```shell
helm upgrade my-hello-kubernetes jhidalgo3-github/hello-kubernetes-chart -f values-message.yaml
```

**Important Note:** Please delete the existing Pod. A new one will be created. After that, you can run the port forward.

💡 Multiple `values.yaml` files can be provided to a Helm installation


Explore the chart on https://artifacthub.io/packages/helm/opsmx/hello-kubernetes or locally:
```shell
helm pull jhidalgo3-github/hello-kubernetes-chart --untar 
```

The chart should be available in the file `hello-kubernetes-chart-3.0.0.tgz` as well as unpacked in the directory `hello-kubernetes`

## Helm charts structure

Explain anatomy of Helm CLI
```shell
helm help
```

A few tricks when working with Helm charts
List description/info for a chart
```shell
helm show chart jhidalgo3-github/hello-kubernetes-chart
```
List all (default) values for a chart.
```shell
helm show values jhidalgo3-github/hello-kubernetes-chart
```
https://artifacthub.io/ is where a lot of charts and also documentation can be found. 
A lot of different charts already exist, obviously. 

💡 For good charts apart from official ones (if available) are the Bitnami ones: https://artifacthub.io/packages/search?kind=0&org=bitnami

## Uninstall

```shell
helm uninstall my-hello-kubernetes
```

💡 Alternative to Helm: [kustomize](https://kustomize.io/) 
