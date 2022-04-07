#setenforce 0
#sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
#echo "done"

cat <<EOM >/etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
echo "repo added"

yum install kubeadm docker -y

systemctl restart docker && systemctl enable docker
systemctl   restart kubelet && systemctl enable kubelet
kubeadm version

systemctl start docker
systemctl enable docker
cat <<EOM >/etc/docker/daemon.json
{
    "exec-opts": ["native.cgroupdriver=systemd"]
}
EOM


	sudo systemctl daemon-reload
	sudo systemctl restart docker
	sudo systemctl restart kubelet
	#sudo swapoff -a
	#sudo sed -i '/ swap / s/^/#/' /etc/fstab
	#sysctl net.bridge.bridge-nf-call-iptables=1
	#sysctl net.bridge.bridge-nf-call-ip6tables=1
