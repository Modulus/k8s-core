# Install istio helm
$ curl -L https://git.io/getLatestIstio | sh -
cd istio-1.0.2
kubectl apply -f install/kubernetes/helm/istio/templates/crds.yaml
helm template install/kubernetes/helm/istio --name istio --namespace istio-system > $HOME/istio.yaml
or
helm install install/kubernetes/helm/istio --name istio --namespace istio-system

**more details here: https://istio.io/docs/setup/kubernetes/helm-install/**


# Install istio helm template
helm template install/kubernetes/helm/istio --name istio --namespace istio-system -f ~/GitProjects/k8s-core/istio/values.cloud.yml > ~/GitProjects/k8s-core/istio/istio.yaml


# Enable sidecar auto injection in namespace
kubectl label namespace demo istio-injection=enabled



### ON GCP
kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole=cluster-admin \
  --user="$(gcloud config get-value core/account)"

# Delete
kubectl delete -f install/kubernetes/helm/istio/templates/crds.yaml -n istio-system
helm delete istio --purge