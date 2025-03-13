# Basics

[⬅️ Back to the OpenShift overview](README.md)

Generally, you can achieve all things OpenShift cluster related either using the Web Console or the CLI (using the `oc` binary). The choice is yours! For this example however, the **Web Console does not allow you to create "just a pod"** - the most basic unit you can deploy via Web Console is an app which we'll discuss [after](oc-apps.md).

*Note: if you haven't configured your cluster connection, go to [oc-connect.md](./oc-connect.md)*


Run a simple pod using the [httpd-2.4 image][1]:
```shell
oc run httpd --image ubi8/httpd-24 --port 8080
```

Have a look at all pods in your project:
```shell
oc get pod
```

Get specifically the previously created "httpd" pod:
```shell
oc get pod httpd
```

Check the logs of that pod:
```shell
oc logs httpd
```

Get a better description of the pod:
```shell
oc describe pod httpd
```

📝 Can you figure out where (i.e. on which node) the pod is running?


[1]: https://catalog.redhat.com/software/containers/ubi8/httpd-24/
