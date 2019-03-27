helm install -n storage --namespace openebs-system stable/openebs


# Set default storage class

kubectl pathc storageclass openebs-jiva-gpd-3repl -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'