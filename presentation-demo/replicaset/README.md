# Checking Deployment Versions aka Rollouts

Changing a deployment triggers an event on its replica sets:

```shell
kubectl describe deployment/some-app
```

Check the rollouts directly:

```shell
kubectl rollout history deployment/some-app
```

You can inspect each rollout in more detail:

```shell
kubectl rollout history deployment/some-app --revision=1
kubectl rollout history deployment/some-app --revision=2
```

Note how a rollout is only concerned about the *pod template*, not about other deployment properties like replicas.

# Rollback

```shell
kubectl rollout undo deployment/some-app
```

```shell
kubectl rollout undo deployment/some-app --to-revision=2
```