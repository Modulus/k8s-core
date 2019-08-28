# Where did this come from?
source: https://kubernetes-sigs.github.io/aws-alb-ingress-controller/guide/external-dns/setup/

# Notes
1. wget https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.0/docs/examples/external-dns.yaml
2. Edit the --domain-filter flag to include your hosted zone(s)

**The following example is for a hosted zone test-dns.com**
args:
- --source=service
- --source=ingress
- --domain-filter=test-dns.com # will make ExternalDNS see only the hosted zones matching provided domain, omit to process all available hosted zones
- --provider=aws
- --policy=upsert-only # would 

3. kubectl apply -f external-dns.yaml
4. kubectl logs -f -n kube-system $(kubectl get po -n kube-system | egrep -o 'external-dns[A-Za-z0-9-]+')
    Should look like this:
        time="2017-09-19T02:51:54Z" level=info msg="config: &{Master: KubeConfig: Sources:[service ingress] Namespace: FQDNTemplate: Compatibility: Provider:aws GoogleProject: DomainFilter:[] AzureConfigFile:/etc/kuberne tes/azure.json AzureResourceGroup: Policy:upsert-only Registry:txt TXTOwnerID:my-identifier TXTPrefix: Interval:1m0s Once:false DryRun:false LogFormat:text MetricsAddress::7979 Debug:false}"
time="2017-09-19T02:51:54Z" level=info msg="Connected to cluster at https://10.3.0.1:443"

## Installing the alb ingress controller
https://kubernetes-sigs.github.io/aws-alb-ingress-controller/guide/controller/setup/

1. helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
2. helm install incubator/aws-alb-ingress-controller --set autoDiscoverAwsRegion=true --set autoDiscoverAwsVpcID=true --set clusterName=MyClusterName
