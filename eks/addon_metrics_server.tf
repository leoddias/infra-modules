resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "metrics-server"
  version    = "2.11.0"
  namespace  = "kube-system"
  timeout    = 1200

  //K8s cant resolve panamericano.com.br in EC2 (http://169.254.169.254/latest/meta-data/local-hostname)
  set {
    name  = "args[0]"
    value = "--kubelet-preferred-address-types=InternalIP"
  }

  depends_on = [null_resource.wait_for_eks]
}