#!/bin/bash
set -e
sudo yum-config-manager --enable ol7_kvm_utils
sudo yum -y install qemu
sudo yum-config-manager --enable *addons
sudo yum -y install docker-engine
sudo systemctl start docker
sudo systemctl enable docker
sudo yum install oracle-olcne-release-el7
sudo yum install kata-runtime
cat /etc/sysconfig/docker | sed -r $'s!^OPTIONS=.*!OPTIONS=\'-D --add-runtime kata-runtime=/usr/bin/kata-runtime\'!' > tmp.txt
sudo mv tmp.txt /etc/sysconfig/docker
sudo systemctl daemon-reload
sudo systemctl restart docker
