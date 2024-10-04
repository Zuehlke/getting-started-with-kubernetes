# Checking Deployment Versions aka Rollouts

Changing a deployment triggers an event on its replica sets:

```shell
kubectl describe deployment/webserver
```

Check the rollouts directly:

```shell
kubectl rollout history deployment/webserver
```

You can inspect each rollout in more detail:

```shell
kubectl rollout history deployment/webserver --revision=1
kubectl rollout history deployment/webserver --revision=2
```

Note how a rollout is only concerned about the *pod template*, not about other deployment properties like replicas.

# Rollback

```shell
kubectl rollout undo deployment/webserver
```

```shell
kubectl rollout undo deployment/webserver --to-revision=2
```