#!/bin/bash
apt-get update -qq
apt-get install -y curl

IFACE=$(ip -o -4 addr show | awk '$4 ~ /^192\.168\.56\./ {print $2}')

until [ -f /vagrant/node-token ]; do sleep 2; done
TOKEN=$(cat /vagrant/node-token)

curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 \
  K3S_TOKEN=$TOKEN \
  INSTALL_K3S_EXEC="agent --node-ip=192.168.56.111 --flannel-iface=$IFACE" sh -