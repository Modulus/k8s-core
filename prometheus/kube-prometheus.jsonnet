// kube-state-metrics-deployment
// node-exporeter-daemoset
// prometheus-adapter-deployment
// prometheus-operator-deployment
// + set volume to
 
local k = import 'ksonnet/ksonnet.beta.3/k.libsonnet';
 
local pvc = k.core.v1.persistentVolumeClaim;
 
local kp =
  (import 'kube-prometheus/kube-prometheus.libsonnet') +
  (import 'kube-prometheus/kube-prometheus-kubespray.libsonnet') +
  (import 'kube-prometheus/kube-prometheus-all-namespaces.libsonnet')
  // Uncomment the following imports to enable its patches
  // (import 'kube-prometheus/kube-prometheus-anti-affinity.libsonnet') +
  // (import 'kube-prometheus/kube-prometheus-managed-cluster.libsonnet') +
  // (import 'kube-prometheus/kube-prometheus-node-ports.libsonnet') +
  // (import 'kube-prometheus/kube-prometheus-static-etcd.libsonnet') +
  // (import 'kube-prometheus/kube-prometheus-thanos-sidecar.libsonnet') +
  // (import 'kube-prometheus/kube-prometheus-custom-metrics.libsonnet') +
  {
    _config+:: {
      namespace: 'monitoring',
      imageRepos+:: {
        prometheus: "quay.io/prometheus/prometheus",
        alertmanager: "quay.io/prometheus/alertmanager",
        kubeStateMetrics: "carlosedp/kube-state-metrics",
        kubeRbacProxy: "scav/kube-rbac-proxy",
        nodeExporter: "quay.io/prometheus/node-exporter",
        prometheusOperator: "quay.io/coreos/prometheus-operator",
        prometheusAdapter: "directxman12/k8s-prometheus-adapter",
      },
      versions+:: {
        prometheusOperator: 'v0.40.0',
        kubeRbacProxy: 'latest',
        prometheusAdapter: 'v0.7.0',
        kubeStateMetrics: '1.9.6',
      },
      prometheus+:: {
        namespaces+: [
          'openebs', 
          'metallb-system'
        ],
      },
    },
    // grafana+:: {
    //   volumeClaimTemplate:
    //     pvc.new()+
    //     pvc.mixin.spec.withAccessModes('ReadWriteOnce') +
    //     pvc.mixin.spec.resources.withRequests({ storage: '10Gi' }) +
    //     pvc.mixin.spec.withStorageClassName('openebs-sc-statefulset') +
    //     pvc.mixin.spec.name('grafana-claim')
    // },
    prometheus+:: {
      serviceMonitorCstore: {
        apiVersion: 'monitoring.coreos.com/v1',
        kind: 'ServiceMonitor',
        metadata: {
          name: 'cstor',
          namespace: 'openebs',
        },
        labels: {
          'app': 'cstor-pool',
        },
        spec: {
          jobLabel: 'cstor',
          endpoints: [
            {
              port: '9500',
              path: '/metrics',
              scheme: 'http',
            },
          ],
          namespaceSelector: {
            matchNames: [
              'openebs',
            ],
          },
          selector: {
            matchLabels: {
              app: 'cstor-pool',
            },
          },
        },
      },
      prometheus+: {
        spec+: {
          retention: '30d',
          storage: { 
            volumeClaimTemplate: 
              pvc.new() +
              pvc.mixin.spec.withAccessModes('ReadWriteOnce') +
              pvc.mixin.spec.resources.withRequests({ storage: '100Gi' }) +
              pvc.mixin.spec.withStorageClassName('openebs-sc-statefulset'),
          },
        }, 
      },
    },  
  };
 
{ ['setup/0namespace-' + name]: kp.kubePrometheus[name] for name in std.objectFields(kp.kubePrometheus) } +
{
  ['setup/prometheus-operator-' + name]: kp.prometheusOperator[name]
  for name in std.filter((function(name) name != 'serviceMonitor'), std.objectFields(kp.prometheusOperator))
} +
// serviceMonitor is separated so that it can be created after the CRDs are ready
{ 'prometheus-operator-serviceMonitor': kp.prometheusOperator.serviceMonitor } +
{ ['node-exporter-' + name]: kp.nodeExporter[name] for name in std.objectFields(kp.nodeExporter) } +
{ ['kube-state-metrics-' + name]: kp.kubeStateMetrics[name] for name in std.objectFields(kp.kubeStateMetrics) } +
{ ['alertmanager-' + name]: kp.alertmanager[name] for name in std.objectFields(kp.alertmanager) } +
{ ['prometheus-' + name]: kp.prometheus[name] for name in std.objectFields(kp.prometheus) } +
{ ['prometheus-adapter-' + name]: kp.prometheusAdapter[name] for name in std.objectFields(kp.prometheusAdapter) } +
{ ['grafana-' + name]: kp.grafana[name] for name in std.objectFields(kp.grafana) }
