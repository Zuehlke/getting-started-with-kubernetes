# Storage
[⬅️ Back to Kubernetes overview](README.md)

The goal of this exercise is to create a persistent volume (PV) & persistent volume claim (PVC) and use it in a pod.

Let's create a persistent volume claim (PVC).
```
kubectl apply -f kubernetes/storage/pvc.yaml
```

💡 Many things happen(ed) behind the scenes.

📝 Can you figure out the StorageClass and the size of the created PVC?

📝 Was a persistent volume (PV) created as well? If yes, what is the name and how can I see it?

Create the YAML necessary for a new deployment using an image of your choice such as `ubi8/httpd-24`, `chtime/via` or `nginx`. Add the Volume Mount to the *container* spec:

```yaml
    volumeMounts:
    - mountPath: /volumes/persistent
      name: persistent-volume
```

In order to use the volume in a container, you must request it on the pod level as well, i.e. inside the *pod* spec:

```yaml
volumes:
- name: persistent-volume
  persistentVolumeClaim:
    claimName: volume-claim
```

💡 If you need to generate YAML for a pod you can use the parameter `--dry-run=client -o yaml`.

Create a file that is visible or used in the image you deployed, e.g.
- `ubi8/httpd-24`:`/var/www/html/index.html`
- `chtime/via`: `/volumes/persistent/anything` (this image lists all files under the `VOLUMES_PATH` set as environment variable)
- `nginx`: `/usr/share/nginx/html`

```shell
kubectl exec -it deployment/storage-app -- sh
echo 'Hello from storage' > /var/www/html/index.html
```

Start port-forwarding and check the results in your browser.

```shell
kubectl port-forward deployment/storage-app 8080:8080
```

📝 Delete the deployment, observe the pods disappear and create a new one using the same claim `volume-claim` as you did before. How is the pod behaving?

📝 Delete all resources you have created.
