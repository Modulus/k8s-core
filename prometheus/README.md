helm install --name prometheus  stable/prometheus -f values.yml
helm install --name grafana stable/grafana -f grafana/values.yml
