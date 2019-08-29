# Install elasticsearch
helm install -f values.es.yaml--name elasticsearch elastic/elasticsearch --set imageTag=7.3.0

# install kibana
helm install -n kibana --namespace -f kibana.values.cloud.yml demo stable/kibana