#!/bin/bash
apt-get update -qq
apt-get install -y curl

IFACE=$(ip -o -4 addr show | awk '$4 ~ /^192\.168\.56\./ {print $2}')

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server \
  --node-ip=192.168.56.110 \
  --flannel-iface=$IFACE \
  --write-kubeconfig-mode=644" sh -

until [ -f /var/lib/rancher/k3s/server/node-token ]; do sleep 2; done
cp /var/lib/rancher/k3s/server/node-token /vagrant/node-token
chmod 644 /vagrant/node-token