#!/bin/bash

if [ ! -d ~/alcor_logs ]; then
    mkdir -p ~/alcor_logs
fi

export KUBECONFIG=/etc/kubernetes/admin.conf

echo "***** Delete Alcor Microservices *****" 2>&1 | tee ~/alcor_logs/alcor.log
/root/kube-yaml/deleteYaml.sh 2>&1 | tee -a ~/alcor_logs/alcor.log

cd /root
echo "***** Download and build images on each Node *****" 2>&1 | tee -a ~/alcor_logs/alcor.log
./deploy-alcor-nodes.sh update-alcor.sh alcor-nodes-ips

echo "***** Deploy Aclor Cluster *****" 2>&1 | tee -a ~/alcor_logs/alcor.log
cd /root/kube-yaml
Distrinet-mchen/scripts/deploy-k8s-kvm/alcor/kubernetes/createYaml.sh 2>&1 | tee -a ~/alcor_logs/alcor.log
cd /root

sleep 30s

echo "***** Alcor Microservices Status *****" 2>&1 | tee -a ~/alcor_logs/alcor.log
kubectl get pods -A 2>&1 | tee -a ~/alcor_logs/alcor.log

echo "***** Create Segments *****" 2>&1 | tee -a ~/alcor_logs/alcor.log
curl -X POST -H "Content-Type: application/json" -H "Accept: */*" "http://localhost:30001/segments/createDefaultTable" 2>&1 | tee -a ~/alcor_logs/alcor.log

echo "***** Register Nodes *****" 2>&1 | tee -a ~/alcor_logs/alcor.log
curl -X POST -H "Content-Type: multipart/form-data" -F "file=@medina-nodes.json" "http://localhost:30007/nodes/upload" 2>&1 | tee -a ~/alcor_logs/alcor.log