# Install elasticsearch
helm install -n elasticsearch --namespace demo -f values.cloud.yml incubator/elasticsearch

# install kibana
helm install -n kibana --namespace -f kibana.values.cloud.yml demo stable/kibana