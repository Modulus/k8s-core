
SECRET=$(kubectl get sa deployment -n deployment -o jsonpath="{.secrets[0].name}")
echo "secret: $SECRET"

CA=$(kubectl get secret $SECRET -n deployment -o jsonpath="{.data.ca\.crt}")
echo "ca: $CA"

TOKEN=$(kubectl get secret $SECRET -n deployment -o jsonpath="{.data.token}")
echo "token: $TOKEN"

context=$(kubectl config current-context)
echo -e "\\nSetting current context to: $context"

CLUSTER_NAME=$(kubectl config get-contexts "$context" | awk '{print $3}' | tail -n 1)
echo "Cluster name: ${CLUSTER_NAME}"

ENDPOINT=$(kubectl config view \
-o jsonpath="{.clusters[?(@.name == \"${CLUSTER_NAME}\")].cluster.server}")
echo "Endpoint: ${ENDPOINT}"

