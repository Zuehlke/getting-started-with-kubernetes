# OpenShift App Examples

- From an existing OCI image: `registry.redhat.io/ubi8/httpd-24`
- From a Dockerfile: `https://github.com/chtime/via`
    - *remember to change the service port on the deployment to 8000* (where `via` listens on)
- From an OpenShift app template in the Developer Catalog: `Rails + PostgreSQL`, `CakePHP + PostgreSQL`. *Note*: At the time of writing, all templates generated:
    - deprecated `DeploymentConfig`s (instead of `Deployment`s)
    - routes without TLS termination, meaning you must call the route endpoint via HTTP (or add e.g. edge tls termination)
