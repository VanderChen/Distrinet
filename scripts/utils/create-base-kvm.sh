#!/bin/bash

virt-install --name ubuntu-1804 \
	--os-variant ubuntu18.04 \
	--vcpus 6 \
	--ram 8192 \
	--location http://ftp.ubuntu.com/ubuntu/dists/bionic/main/installer-amd64/ \
	--disk path=/var/lib/libvirt/images/ubuntu-1804.qcow2,size=40 \
	--network bridge=virbr0,model=virtio \
	--graphics none \
	--extra-args='console=ttyS0,115200n8 serial'