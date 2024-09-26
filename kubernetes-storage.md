# Storage
[⬅️ Back to Kubernetes overview](README.md)

The goal of this exercise is to create a persistent volume (PV) & persistent volume claim (PVC) and use it in a nginx pod. 

Let's create just a persistent volume claim (PVC).
```
k apply -f kubernetes/storage/only_pvc.yaml 
```
💡 Many things happened.

📝 Can you figure out the StorageClass and the size of the created PVC. 

📝 Was a persistent volume (PV) created as well? If yes, what is the name and how can I see it? 

Prepare the YAML for new pod named **nginxpod** with a Nginx image. Add the Volume Mount to your `Container Pod Spec`.
```yaml
    volumeMounts:
    - mountPath: /usr/share/nginx/html
      name: data-volume
```
Add the Volume Mount to your `Pod Spec`.

```yaml
volumes:
- name: data-volume
  persistentVolumeClaim:
    claimName: nginxclaim
```
💡 We suggest that you create one YAML for your pod. 

💡 If you need to create YAML for POD you can use the parameter `--dry-run=client -o yaml`.

Change the content of the `index.html`.
```
k exec -it nginxpod -- sh
echo 'Hello from storage' > /usr/share/nginx/html/index.html
```
Start port-forwarding and check the results in your browser.
```
kubectl port-forward pod/nginxpod 8888:80
```
📝 Delete the pod and create a new nginx pod using the same claim `nginxclaim` as you did before. How is the pod behaving? 

📝 Delete all resources you have created.
