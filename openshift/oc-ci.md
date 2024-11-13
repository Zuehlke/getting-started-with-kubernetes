# OpenShift Continuous Integration

[⬅️ Back to the OpenShift overview](README.md)

You've seen in the [apps tutorial](oc-apps.md) that OpenShift can automatically generate a bunch of resources for a given application, based solely on an OCI image (e.g. httpd). 

If you build your own applications and images, you usually need to publish a new image on source code changes. Here's where OpenShift's BuildConfigs come into play: BuildConfigs hold configuration in order for the cluster to automatically generate new images for consumption in deployments.

*Keep in mind that you will need to delete or replace resources from the other respective approach if you change from CLI to UI or vice-versa.*

## CLI

- Create the app:
```shell
oc new-app --name=via-app --labels='app=via-app' https://github.com/chtime/via
``` 

📝 Inspect the resources created by `oc new-app`. What is different when you don't have a prebuilt OCI image?

- Inspect the BuildConfig:
```shell
oc describe buildconfig via-app
``` 
- Inspect the resources, particularly the Deployment and its `spec.containers.image`. 
- Note: You again would need to manually create a route to access the service over the web:
```shell
oc create route edge --service=via-app
```

## Web Console

- Add an application through the console and import from Git. You can use a homebrew repository for this: [https://github.com/chtime/via](https://github.com/chtime/via)
- After OpenShift finished parsing the repository, review the options available to you.

📝 Consider the import strategies. Why is Dockerfile recommended, and why not the others?

💡 Take note of the build options. 

⚠️📝 The suggested (service's) target port deviates from the standards employed in the repository. Try to find the proper port value in the repository.

- Confirm creation of the app
- Follow the topology view, and check the Builds in the side menu.
- Once the deployment successfully scaled to 1 replica, open the generated route's URL.

## Exercise

If you don't feel too comfortable with Git & GitHub, you can just skip the first block.

- 📝 Code Changes
    - Fork the repository, and redeploy an app pointing to your fork
    - 📝 How would you delete all resources created before with the `app=via-app` label?
    - *Optionally* configure webhooks:
        - Follow the steps outlined in the [repository's resources](https://github.com/chtime/via/blob/master/resources/README.md). If you have problems with this, let us know - setting up webhooks can be a little tricky.
        - Make sure the GitHub webhook test returns a success ✅
    - Make code changes (e.g. replacing the lorem ipsum text) and push back to your repository.
    - With webhooks configured, you should immediately see a build being started on the cluster.
    - If you don't have webhooks set up, you can trigger a build manually (`oc start-build via-app`)
    - ⁉️ At the time of writing, Deployments would not get automatically updated. Editing the deployment and saving it without changes triggers the upgrade however. 
- 📝 Can you reconstruct how BuildConfig, ImageStream and Deployments are linked? 
