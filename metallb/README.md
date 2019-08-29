# Layer 2 config
kubectl create ns metallb-system
helm install -f values.yaml --namespace metallb-system --name metallb stable/metallb