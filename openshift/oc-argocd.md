# ArgoCD on OpenShift

[⬅️ Back to the OpenShift overview](README.md)

*Note*: This applies to Kubernetes just as much, but the examples below make use of Route resources, which are OpenShift-exclusive.

## Links

- [GitOps repository on gitea](https://gitea.apps.zuehlkeacademy.switzerlandnorth.aroapp.io) (use the same login as the cluster)
- [ArgoCD Instance](https://argocd-server-argocd.apps.zuehlkeacademy.switzerlandnorth.aroapp.io/)

## Lab

The ArgoCD instance deployed on our cluster is configured to automatically generate applications for manifests found in git repositories matching the following pattern:
- on the gitea server linked above
- in a repo named "gitops" under your user account: e.g. if you're demo: `$gitea-host/demo/gitops`)
- inside an application folder in that repository: e.g. `applications/deployment.yaml` will be deployed & managed by ArgoCD

For this to work, you need to:
- Fork the original gitops repository: `$gitea-host/gitops/gitops`
- Make sure you keep the repository name as "gitops" (but under your user account)
- Add an `applications/` + your username folder at the root.
- Add your manifests in there, commit & push
- ArgoCD will only deploy changes made to the `main` branch; one application for each folder in `/applications/`.

📝 Add some resources to the repository in your own folder (on the main branch!), at the minimum a deployment.

*Tip*: Reuse resource from before or create a new one:
`oc create deployment httpd --image=ubi8/httpd-24 --dry-run=client -o yaml`

📝 Make some changes to these resources, e.g. replace or update the image, add a service or route, etc. Before you push, make sure you have an eye open on your application on ArgoCD and watch the changes happen!

📝 Consider where and how you could benefit from such an approach.
