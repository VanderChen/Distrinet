distrinet-mchen/scripts/deploy-alcor-k8s/alcor-deploy.sh


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