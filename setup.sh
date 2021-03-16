#!/bin/bash

PROJECT=learn2build-lab-295923
INSTANCE=flinkstech-k8s
ZONE=us-central1-c

MACHINE_TYPE=e2-medium
IMAGE=ubuntu-1604-xenial-v20210224
IMAGE_PROJECT=ubuntu-os-cloud

gcloud compute instances create ${INSTANCE} \
--machine-type=${MACHINE_TYPE} \
--preemptible \
--tags=microk8s \
--image=${IMAGE} \
--image-project=${IMAGE_PROJECT} \
--zone=${ZONE} \
--project=${PROJECT} \
--metadata=startup-script='
!# /bin/bash

# Install microk8s
snap install microk8s --classic --channel=1.19/stable
microk8s status --wait-ready
microk8s enable dns registry helm3

# Install Helm 3 Client
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh


# Install NGINX Ingress Controller
microk8s kubectl create namespace ingress-controller
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
microk8s helm3 install --namespace ingress-controller ingress-nginx ingress-nginx/ingress-nginx
'

echo -en "\n\ngcloud compute ssh ${INSTANCE} --zone=${ZONE} --project=${PROJECT}\n"
