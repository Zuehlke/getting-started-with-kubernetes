# Pod Security
[⬅️ Back to Kubernetes overview](README.md)

## Precondition

You are required to install [Kyverno and Policy Reporter](https://kyverno.github.io/policy-reporter/guide/getting-started) to see pod configuration vulnerabilities.


## Identifying security configuration issues

Inspect and apply the template "hello-kubernetes" example under `kubernetes/hello-kubernetes/resources.yaml` if not already installed when reading chapter [Environment variables, ConfigMaps & Secrets](kubernetes-config-map-secret.md)
```shell
kubectl apply -f kubernetes/hello-kubernetes/resources.yaml
````

After the deployment check the Policy Reporter to see if any security issues have been identified with this deployment.

You should see the following policies with status fail:
- disallow-privilege-escalation
- drop-cap-net-raw
- require-requests-limits
- require-ro-rootfs
- require-run-as-nonroot

Read through the explanation of these policies.
Let's now try to see how these issues can be fixed.

## Fixing security configuration issues

### Fixing disallow-privilege-escalation

Modify `kubernetes/hello-kubernetes/resources.yaml` by adding a `securityContext` context element with `allowPrivilegeEscalation: false`:

````
    ...
    spec:
      containers:
        - name: hello-kubernetes
          image: ghcr.io/chtime/via:master
          ports:
            - name: http
              containerPort: 8000
              protocol: TCP
          livenessProbe:
            httpGet:
              path: /
              port: http
          readinessProbe:
            httpGet:
              path: /
              port: http
          env:
            - name: MESSAGE
              value: "👋 Hello from Deployment"
          securityContext:
            allowPrivilegeEscalation: false
````

Deploy the change configuration by running
```shell
kubectl apply -f kubernetes/hello-kubernetes/resources.yaml
````
Check the Policy Reporter to see if the status of the Policy disallow-privilege-escalation has changed from fail to pass.

### Fixing drop-cap-net-raw

Modify `kubernetes/hello-kubernetes/resources.yaml` by adding a `capabilities` block to the  `securityContext`:

````
    ...
    spec:
      containers:
        - name: hello-kubernetes
          image: ghcr.io/chtime/via:master
          ports:
            - name: http
              containerPort: 8000
              protocol: TCP
          livenessProbe:
            httpGet:
              path: /
              port: http
          readinessProbe:
            httpGet:
              path: /
              port: http
          env:
            - name: MESSAGE
              value: "👋 Hello from Deployment"
          securityContext:
            allowPrivilegeEscalation: false
            capabilities:
              drop:
                - CAP_NET_RAW
````

Deploy the change configuration by running
```shell
kubectl apply -f kubernetes/hello-kubernetes/resources.yaml
````
Check the Policy Reporter to see if the status of the policy drop-cap-net-raw has changed from fail to pass.

This example illustrates some of the weaknesses of the Policy Reporter (Kyverno). Adding the following block would have implicitly removed the CAP_NET_RAW capabilities.
````
          ...
          securityContext:
            allowPrivilegeEscalation: false
            capabilities:
              drop:
                - ALL
````
However, since the Policies are applied using pattern matching this change would have not elimited the 'drop-cap-net-raw' warning.

### Fixing require-requests-limits

Modify `kubernetes/hello-kubernetes/resources.yaml` by adding a `resources` block to the container element:

````
    ...
    spec:
      containers:
        - name: hello-kubernetes
          image: ghcr.io/chtime/via:master
          ports:
            - name: http
              containerPort: 8000
              protocol: TCP
          livenessProbe:
            httpGet:
              path: /
              port: http
          readinessProbe:
            httpGet:
              path: /
              port: http
          env:
            - name: MESSAGE
              value: "👋 Hello from Deployment"
          resources:
            requests:
              memory: "16Mi"
              cpu: "50m"
            limits:
              memory: "64Mi"
````

Deploy the change configuration by running
```shell
kubectl apply -f kubernetes/hello-kubernetes/resources.yaml
````
Check the Policy Reporter to see if the status of the policy require-requests-limits has changed from fail to pass.

### Fixing require-run-as-nonroot

Modify `kubernetes/hello-kubernetes/resources.yaml` by adding  `runAsNonRoot: true`, `runAsUser: 1000`, and `runAsGroup: 3000` to the `securityContext' element:

````
    ...
          securityContext:
            allowPrivilegeEscalation: false
            runAsNonRoot: true
            runAsUser: 1000
            runAsGroup: 3000
            capabilities:
              drop:
                - CAP_NET_RAW
````

Deploy the change configuration by running
```shell
kubectl apply -f kubernetes/hello-kubernetes/resources.yaml
````
Check the Policy Reporter to see if the status of the policyrequire-run-as-nonroot has changed from fail to pass. 


### Fixing require-ro-rootfs

Modify `kubernetes/hello-kubernetes/resources.yaml` by adding a `readOnlyRootFilesystem: true` to the `securityContext' element:

````
    ...
          securityContext:
            allowPrivilegeEscalation: false
            runAsNonRoot: true
            runAsUser: 1000
            runAsGroup: 3000
            readOnlyRootFilesystem: true
            capabilities:
              drop:
                - CAP_NET_RAW
````


Deploy the change configuration by running
```shell
kubectl apply -f kubernetes/hello-kubernetes/resources.yaml
````
Check the Policy Reporter to see if the status of the policy require-ro-rootfs has changed from fail to pass. You will find that that is not the case. In fact, with this change the Pods fail to start up. 

Take a look a the log of the container. It fails to startup because it has no write access to some directory.

This issue cannot be solved by restricting the container in the deploment configuration. It requires the use of an image that does not rely on a writable file system.

Before you move on to the next section don't forget to remove `readOnlyRootFilesystem: true` from the configuration.


## Applying a Pod Security Standards with Namespace Labels 

Kubernetes can also enforce security polices on a namespace without Policy Reporter (Kyverno). The available policies are:
- privilgeded
- baseline
- restricted

To check if your namespace complies with the baseline standard run the following command:

````
kubectl label --dry-run=server --overwrite ns my-namespace \
  pod-security.kubernetes.io/enforce=baseline \
  pod-security.kubernetes.io/enforce-version=v1.31
````
The 'dry-run=server' flag will run the command in dry run mode, giving you information about how the policy would treat existing pods, without actually modifying the namespace.
Ideally, you should not receive any warnings when running the command.

Now let's be more strict and test the restricted standard by running the following command:
````
kubectl label --dry-run=server --overwrite ns my-namespace \
  pod-security.kubernetes.io/enforce=restricted \
  pod-security.kubernetes.io/enforce-version=v1.31
````
You should now receive at least one warning 'unrestricted capabilities, seccompProfile' for the hello-kubernetes pods.

Further changes to the hello-kubernetes deployment and possible other deployments on the namespace would be needed before being able to permanently enforcing the restricted standard. 


## Further Resources
[Kubernetes Security Context Documentation ](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)

[Kubernetes Resource Mangement Documentation ](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)

[Kubernetes Pod Security Standards Documentation ](https://kubernetes.io/docs/concepts/security/pod-security-standards/)

[Kubernetes Enforce Pod Security Standards Documentation ](https://kubernetes.io/docs/tasks/configure-pod-container/enforce-standards-namespace-labels/)