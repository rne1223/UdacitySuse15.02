#!/bin/bash
# Bootstrap machine

### Things to intall
## Python3
## Flask
## Go
## Docker
## Git 
## Docker
## Helm
## Kind

step=1
step() {
    echo "Step $step $1"
    step=$((step+1))
}

## Update package manager zypper
update_zypper() {
    step "===== Updating zypper ====="
    sudo zypper ar --refres https://download.opensuse.org/repositories/devel:/languages:/go/openSUSE_Leap_15.2/ devel # Add repo to install golang
    sudo zypper mr -p 70 devel
    sudo zypper addrepo --refresh https://download.opensuse.org/repositories/system:/snappy/openSUSE_Leap_15.2 snappy
    sudo zypper --gpg-auto-import-keys refresh
}

install_golang() {
    sudo zypper install -y go1.15 
}

##Installing docker 
install_docker() {
    step "===== Installing Docker ====="
    sudo zypper install -y docker python3-docker-compose
    sudo systemctl enable docker
    sudo usermod -G docker -a vagrant 
    sudo systemctl restart docker
    newgrp docker
}

install_go() {
    step "===== Installing GO ====="
    sudo zypper in -y go1.15
}

install_git() {
    step "===== Installing Git ====="
    sudo zypper install -y git
}

install_kind() {
    step "===== Installing Kind cluster====="
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
    chmod +x ./kind
    mv ./kind ~/bin/
}

install_helm() {
    step "===== Installing Helm ====="
    sudo su
    curl -sfL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | sh -
}

install_kubectl() {
    step "===== Installing Kubectl ====="
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    mv ./kubectl ~/bin/
    echo "export KUBECONFIG=~/.kube/my-kubeconfig"
}

modify_bashrc() {
    step "===== Updating Bashrc ====="
    echo "set -o vi" >> ~/.bashrc
    echo "export KUBECONFIG=~/.kube/my-kubeconfig" >> ~/.bashrc

    sudo echo "set -o vi" >> ~/.bashrc
    sudo echo "source /usr/share/bash-completion/bash_completion && source <(kubectl completion bash)" >> ~/.bashrc
    sudo echo "source /usr/share/bash-completion/bash_completion && source <(helm completion bash)" >> ~/.bashrc
    sudo echo "source /usr/share/bash-completion/bash_completion && source <(vi completion bash)" >> ~/.bashrc
    sudo echo "export KUBECONFIG=~/.kube/my-kubeconfig" >> ~/.bashrc
}

main() {
    update_zypper
    install_docker
    install_kind
    install_helm
    install_kubectl
    modify_bashrc

    step "All DONE"
}

main