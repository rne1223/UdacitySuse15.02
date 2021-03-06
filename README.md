## About The Project


This installation guide was created to provide a consistent and smooth experience across Windows and Mac OS while working on [Cloud Native Fundamentals Scholarship Program Nanodegree](https://classroom.udacity.com/nanodegrees/nd064-1). To achieve this goal we will be using [Vagrant](https://www.vagrantup.com/), [VirtualBox](https://www.virtualbox.org/),  [GIT](https://git-scm.com/downloads) and internet connection.

<!-- GETTING STARTED -->
## Prerequisite 
Please install [Vagrant](https://www.vagrantup.com/), [VirtualBox](https://www.virtualbox.org/) and [GIT](https://git-scm.com/downloads) for your operating system.


<!-- GETTING STARTED -->
## Getting Started 

1. Use git to clone this repo
   ```sh
   git clone https://github.com/rne1223/UdacitySuse15.02
   ```
2. Open a terminal in the cloned directory and type 
   ```sh
   vagrant up
   ```

<!-- Details -->
## Details of what is happening in the background
### TLDR:
Vagrant is going to create an OpenSuse 15.02 image with python, go, docker, kind, kubernetes and helm. The kubernetes cluster will start automatically as soon you login.

### DETAILS:
This line  ```config.vm.provision "shell" , path: "./bootstrap.sh``` in our Vagrantfile will start a script when vagrant boots our OpenSuse image for the first time. The script, which you can examine [here](https://raw.githubusercontent.com/rne1223/UdacitySuse15.02/master/bootstrap.sh) will:

1. Update zypper
2. Install all the necessary software such as docker, python etch
3. Start the kubernetes cluster with kind
4. Update ~/.bashrc to use helm, kubectl and kinds' autocompletion :) 
5. Update ~/.profile to start the kubernetes cluster 


## Acknowledgements
* [Readme Template](https://github.com/othneildrew/Best-README-Template/blob/master/README.md)
* [Kubernetes docs](https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-bash-linux/)