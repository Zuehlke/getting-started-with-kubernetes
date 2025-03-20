# ArgoCD on OpenShift 

[⬅️ Back to the OpenShift overview](README.md)

*Note*: This applies to Kubernetes just as much, but the examples below make use of Route resources, which are OpenShift-exclusive.

## Links

- [GitOps repository on a gitea](https://gitea.apps.zuehlkeacademy.germanywestcentral.aroapp.io/gvz-academy/gitops) (use the same login as the cluster)
- [ArgoCD Instance](https://argocd-server-argocd.apps.zuehlkeacademy.germanywestcentral.aroapp.io/applications)

## Lab

The ArgoCD instance deployed on our cluster is configured to automatically generate applications for manifests inside the GitOps repository linked above; see the contained `README.md` for more details. You will need to change files in that repository!

- You can either do the edits in directly in a browser, or use a git client to clone and change the repository.
- You should only create resources in the `/applications/<your-username>` folder.
- ArgoCD will only deploy changes made to the `main` branch; one application for each folder in `/applications/`.

📝 Add some resources to the repository in your own folder (on the main branch!), at the minimum a deployment.

*Tip*: Reuse resource from before or create a new one:
`oc create deployment httpd --image=ubi8/httpd-24 --dry-run=client -o yaml`

📝 Make some changes to these resources, e.g. replace or update the image, add a service or route, etc. Before you push, make sure you have an eye open on your application on ArgoCD and watch the changes happen!

📝 Consider where and how you could benefit from such an approach. 
