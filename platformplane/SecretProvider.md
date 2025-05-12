# Secret Provider Lab

In this lab we will create a secret that is provied by the Vault secret provider.

In advance a kv secret in needs to be created with the path `db` and key `db-password`

# Creating the secret provider

Now we need to create a secret provider class that tells the 

```yaml


apiVersion: secrets-store.csi.x-k8s.io/v1
kind: SecretProviderClass
metadata:
  name: demo-secrets
spec:
  provider: platform # this provider abstracts away HashiCorp Vault and Thycotic

  # --------------------------------------------------------------------------------------------------
  # mandatory section referencing the hashicorp vault secret(s) that will be mounted as a volume
  # --------------------------------------------------------------------------------------------------
  # objectName: corresponds to the mounted file name
  # secretPath: path to the secret in vault ("data" must be added in second position)
  # secretKey; key (name) of the secret in vault
  parameters:
    objects: |
      - objectName: "db-password-object"
        secretPath: "kv/data/db"
        secretKey: "db-password"

  # --------------------------------------------------------------------------------------------------
  # Optional declaration of a Kubernetes secret that will mirror the mounted secret upon pod startup
  # --------------------------------------------------------------------------------------------------
  secretObjects:
    - secretName: db-password # name of the Kubernetes secret you want to create
      type: Opaque # type of the Kubernetes secret
      data: # data section of the Kubernetes secret
        - objectName: db-password-object # must match the objectName from the parameters section
          key: db-password # key (name) of the secret within the data section (the value will be the actual secret you want to use)
```



Now the secret can be provided to resources that demand it.


# Create deployment, that uses the secret

```yaml
# -----------------
# deployment.yaml
# -----------------
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo
  labels:
    app: demo
spec:
  selector:
    matchLabels:
      app: demo
  template:
    metadata:
      labels:
        app: demo
    spec:
      containers:
        - name: demo
          image: alpine
          command: ["/bin/sh"]
          args: ["-c", "sleep infinity"]
          volumeMounts: # mount the secrets store volume into the pod
            - name: secrets-store-inline # matches the volume name declared below
              mountPath: "/mnt/secrets"
              readOnly: true
          env: # building up env vars from Vault secrets
            - name: DB_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: db-password # name of the Kubernetes secret you created above
                  key: db-password

      volumes: # define the secrets store volume
        - name: secrets-store-inline
          csi:
            driver: secrets-store.csi.k8s.io
            readOnly: true
            volumeAttributes:
              secretProviderClass: demo-secrets # as defined in the secretproviderclass.yaml file
```
