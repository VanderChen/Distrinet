#!/bin/bash


cp /var/lib/libvirt/images/ubuntu-1804.qcow2 /var/lib/libvirt/images/distrinet-master.qcow2

virt-install --virt-type kvm \
    --name distrinet-master \
    --os-type=linux
	--os-variant ubuntu18.04 \
	--vcpus 6 \
	--ram 8192 \
	--location http://ftp.ubuntu.com/ubuntu/dists/bionic/main/installer-amd64/ \
	--disk path=/var/lib/libvirt/images/ubuntu-1804.qcow2,size=40 \
    --network bridge=default,model=virtio \
	--network bridge=br-k8s,model=virtio \
	--graphics none \
	--extra-args='console=ttyS0,115200n8 serial'