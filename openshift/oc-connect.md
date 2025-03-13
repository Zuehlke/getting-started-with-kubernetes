# Connecting

[⬅️ Back to the OpenShift overview](README.md)

To connect to the cluster, we recommend using `oc` or `kubectl`; the latter works for most features we're going to use here, but `oc` is obviously the more appropriate given this courses scope.

You can get the `oc` CLI distribution (which also includes `kubectl`) from RedHat directly, e.g. from the [OKD project's website](https://docs.okd.io/4.16/cli_reference/openshift_cli/getting-started-cli.html#cli-getting-started).

Once you have that installed, you can authenticate to the cluster. With the credentials you've been given:
1. go to the web console
2. click your username in top right corner
3. click "Copy login command"
4. confirm your credentials for security purposes
5. click "Display token"
6. copy the command like `oc login --token=sha256~abcdef,,, --server=https://api.the-cluster.ch:6443`
7. you should now be authenticated and authorized; confirm by running some command as `oc get pods --all-namespaces`
8. since by default, you're connecting to the `default` namespace (equivalent to a project), switch to your own in which you have most permissions: `oc project <your-username>`
9. confirm your write permissions by following the steps in [oc-basics.md](./oc-basics.md)

