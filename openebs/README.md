helm install --namespace openebs --name openebs stable/openebs --version 1.1.0 -f values.yml


kubectl apply -f storagePool.yaml
kubectl apply -f storageClass.yaml


1. kubectl edit configmap storage-openebs-ndm-config -n openebs set os-exclude-filter enabled to false
2. kubectl delete po -l component=ndm -n openebs

# To purge all crds

https://docs.openebs.io/docs/next/uninstall.html

ahd "sh purge.sh"

    includePaths: "/dev/sda,sda,/dev/sdb,sdb"
