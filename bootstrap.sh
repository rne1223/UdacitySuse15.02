#!/bin/bash
# Bootstrap machine

ENV_HOME = "/home/vagrant"
ENV_BASHRC = "$ENV_HOME/.bashrc" 
ENV_BIN = "$ENV_HOME/bin"

step=1
step() {
    echo "Step $step $1"
    step=$((step+1))
}

## Update package manager zypper
# update_zypper() {
#     step "===== Updating zypper ====="
#     sudo zypper ar --refresh https://download.opensuse.org/repositories/devel:/languages:/go/openSUSE_Leap_15.2/ devel # Add repo to install golang
#     sudo zypper ar --refresh https://download.opensuse.org/repositories/system:/snappy/openSUSE_Leap_15.2 snappy
#     sudo zypper mr -p 70 devel snappy
#     sudo zypper --gpg-auto-import-keys refresh
# }

# install_golang() {
#     sudo zypper install -y go1.15 
# }

# ##Installing docker 
# install_docker() {
#     step "===== Installing Docker ====="
#     sudo zypper install -y docker python3-docker-compose
#     sudo systemctl enable docker
#     sudo usermod -G docker -a vagrant 
#     sudo systemctl restart docker
#     newgrp docker
# }

# install_go() {
#     step "===== Installing GO ====="
#     sudo zypper in -y go1.15
# }

# install_git() {
#     step "===== Installing Git ====="
#     sudo zypper install -y git
# }

install_kind() {
    step "===== Installing Kind cluster====="
    curl -Lo kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
    chmod +x ./kind
    mv ./kind $(echo $ENV_BIN)
}

install_helm() {
    step "===== Installing Helm ====="
    curl -LO "https://get.helm.sh/helm-v3.6.1-linux-amd64.tar.gz"
    tar xzvf helm-v3.6.1-linux-amd64.tar.gz
    chmod +x linux-amd64/helm
    mv linux-amd64/helm $(echo $ENV_BIN)
    rm linux-amd64* -rf
    rm *.tar.gz
}

install_kubectl() {
    step "===== Installing Kubectl ====="
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    mv ./kubectl $(echo $ENV_BIN)
}

modify_env() {
    step "===== Updating Enviroment ====="

    # echo "set -o vi" >> ~/.bashrc
    # echo 'alias k=kubectl' >>~/.bashrc
    # echo 'complete -F __start_kubectl k' >>~/.bashrc
    # echo "export KUBECONFIG=~/.kube/my-kubeconfig" >> ~/.bashrc

    echo "set -o vi" >> $(echo $ENV_BASHRC)
    echo "source /usr/share/bash-completion/bash_completion && source <(kubectl completion bash)" >> $(echo $ENV_BASHRC)
    echo 'alias k=kubectl' >> $($echo $ENV_BASHRC)
    echo 'complete -F __start_kubectl k' >> $(echo $ENV_BASHRC)
    echo "source /usr/share/bash-completion/bash_completion && source <(helm completion bash)" >> $(echo $ENV_BASHRC)
    echo "source /usr/share/bash-completion/bash_completion && source <(vi completion bash)" >> $(echo $ENV_BASHRC)

    # echo "export KUBECONFIG=~/.kube/my-kubeconfig" >> ~/.bashrc
}

main() {
    update_zypper
    install_docker
    install_go
    install_git
    install_kind
    install_helm
    install_kubectl
    modify_env

    step "All DONE"
}

main