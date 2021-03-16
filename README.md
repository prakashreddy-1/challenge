setup.sh Launches a GCP Compute instance - configurable by:
  - name (INSTANCE)
  - type (MACHINE_TYPE
  - OS (IMAGE + IMAGE_PROJECT)
  - ZONE
  - GCP project (PROJECT)
An instance startup-script:
  - installs microk8s version 1.19 (up to 1.20 supported)
  - enables microk8s apps dns, helm3, and registry
  - installs helm3 client
  - installs NGINX ingress controller via helm3
Microk8s could be configured as a cluster by extending setup.sh to launch one or more additional Compute instances configured with the output of 'microk8s add-node' from the logical master (above)
YAML Kubernetes manifest files deploy:
  - 'flinks' Namespace
  - 'nginx-conf' ConfigMap (includes 'Hello Flinks' index.html)
  - 'flinks-nginx' Deployment (uses 'nginx-alpine' image)
  - 'flinks-nginx' Service (HTTP only)
  - 'flinks-ingress' Ingress (includes 'challenge.domain.local' rule)
