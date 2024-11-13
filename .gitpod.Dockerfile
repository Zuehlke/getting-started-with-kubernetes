FROM gitpod/workspace-base:2024-11-06-20-18-15@sha256:5c176a071e0856192840f5145c5d60c11fe80acb29e7219c2e9bc51e1e966605

ADD --chown=gitpod:gitpod https://dl.k8s.io/release/v1.31.0/bin/linux/amd64/kubectl $HOME/.local/bin/

ADD --chown=gitpod:gitpod https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz /tmp

ADD --chown=gitpod:gitpod https://get.helm.sh/helm-v3.16.2-linux-amd64.tar.gz /tmp/helm.tar.gz

RUN <<EOF
tar xf /tmp/oc.tar.gz oc
mv oc $HOME/.local/bin/
tar xf /tmp/helm.tar.gz linux-amd64/helm
mv linux-amd64/helm $HOME/.local/bin/
chmod +x  $HOME/.local/bin/kubectl $HOME/.local/bin/oc $HOME/.local/bin/helm
EOF
