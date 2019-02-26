kubectl apply -f helm_stuffs.yaml
#curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
#chmod 700 get_helm.sh
#./get_helm.sh
helm init --service-account tiller

