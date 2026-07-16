#!/bin/bash
set -e

apt-get update -qq
apt-get install -y curl

# 1. Docker
curl -fsSL https://get.docker.com | sh
usermod -aG docker vagrant

# 2. kubectl
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# 3. K3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# 4. Argo CD CLI
ARGOCD_VERSION=$(curl -sL https://api.github.com/repos/argoproj/argo-cd/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
curl -sSL -o /usr/local/bin/argocd "https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-amd64"
chmod +x /usr/local/bin/argocd
