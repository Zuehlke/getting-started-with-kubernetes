# OpenShift Apps

[⬅️ Back to the OpenShift overview](README.md)

Apps in OpenShift are bundles of Kubernetes resources. In some trivial cases, the cluster can autogenerate these, in more extensive cases, the maintainer of the "app" can create templates, which can then be interactively filled during importing of the app.

Again, you can do this via CLI or Web Console. *Keep in mind that you will need to delete or replace resources from the other respective approach if you change from CLI to UI or vice-versa.*

We are going to deploy our good old friend, the apache web server, commonly referred to as `httpd`. 

## CLI

- Autogenerate resources for [httpd-2.4][1]:
```shell
oc new-app registry.redhat.io/ubi8/httpd-24 
```

📝 `oc new-app` attaches the label given above to every resource it creates. How can you list all of them?

📝 Can you determine the purpose of the resources created? 

- If you follow the suggestion to `oc expose`, you might run into issues with TLS edge termination. Instead, you can explicitly declare the necessary properties of the route:
```shell
oc create route edge --service=httpd-24
```

📝 Find the route's URL and open it in your browser.

📝 Follow the logs of the deployment as you access the route.


## Web Console

- Open your browser at the web console and login; by default the console lives at `console-openshift-console.apps.<cluster>.<tld>`.
- "+Add" a resource and pick "Container images"
- Enter "registry.redhat.io/ubi8/httpd-24" as name from an external registry to deploy the [httpd-2.4 image][1].
- Naming-related fields will be prefilled using the image as template
- Leave the Deploy resource type as Deployment (*DeploymentConfigs are deprecated*)
- Confirm the target port to be 8080
- Leave route creation enabled.
- Click create and marvel at the topology view lighting up.

📝 Find the route's URL and open it in your browser.

📝 Follow the logs in the web console as you access the route.


[1]: https://catalog.redhat.com/software/containers/ubi8/httpd-24/

