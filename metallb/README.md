# Layer 2 config
kubectl create ns metallb-system
kubectl apply -f config.yml
helm install -f values.local.yml --namespace metallb-system --name metallb stable/metallb