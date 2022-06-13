distrinet-mchen/scripts/deploy-alcor-k8s/alcor-deploy.sh

kubeadm config print init-defaults > kubeadm.conf

https://docs.docker.com/config/daemon/systemd/

[Service]
Environment="HTTP_PROXY=http://proxy.example.com:80"
Environment="HTTPS_PROXY=https://proxy.example.com:443"
Environment="NO_PROXY=localhost,127.0.0.1,docker-registry.example.com,.corp"


sudo mkdir -p /etc/systemd/system/docker.service.d

vim /etc/systemd/system/docker.service.d/http-proxy.conf

sudo systemctl daemon-reload && \
 sudo systemctl restart docker

kubeadm config images pull

unix:///var/run/containerd/containerd.sock, unix:///var/run/cri-dockerd.sock

kubeadm join 172.16.62.205:6443 --token 0pe7xm.p453job6moewovrm --discovery-token-ca-cert-hash sha256:3a486eb9ef14464761a7f80ec945cb21f6d41470f491dde5bff64307833d5dbb --cri-socket unix:///var/run/cri-dockerd.sock

docker pull k8s.gcr.io/pause:3.6

sudo systemctl show --property=Environment docker

kubeadm reset -f --cri-socket unix:///var/run/cri-dockerd.sock