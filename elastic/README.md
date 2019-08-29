# Install elasticsearch

helm repo add elastic https://helm.elastic.co

helm install --namespace monitoring-f values.es.yaml --name elasticsearch elastic/elasticsearch

helm install --namespace monitoring -f values.es.yaml --name elasticsearch elastic/elasticsearch --set imageTag=7.3.0

# Install kibana
helm repo add elastic https://helm.elastic.co

helm install -f values.ki.yaml --namespace monitoring --name kibana elastic/kibana