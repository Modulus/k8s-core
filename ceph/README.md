# Install the operator

helm repo add rook-release https://charts.rook.io/release
helm install --namespace rook-ceph rook-release/rook-ceph

# Create storage cluster 
kubectl change-ns rook-ceph
kubectl apply -f cluster.yaml 

# Delete
kubectl -n rook-ceph delete cephcluster rook-ceph
alt.
kubectl delete cluster.yaml

helm delete relase-name --purge