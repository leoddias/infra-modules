resource "kubernetes_namespace" "kubernetes_dashboard" {
  metadata {
    name = "kubernetes-dashboard"
  }

  depends_on = [null_resource.wait_for_eks]
}

resource "kubernetes_service_account" "dash_admin_user" {
  metadata {
    name      = "dash-admin-user"
    namespace = kubernetes_namespace.kubernetes_dashboard.metadata.0.name
  }
}

resource "kubernetes_cluster_role_binding" "dash_admin_user" {
  metadata {
    name      = "dash-admin-user"    
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.dash_admin_user.metadata.0.name
    namespace = kubernetes_namespace.kubernetes_dashboard.metadata.0.name
  }
}

resource "helm_release" "k8s_dashboard" {
  name       = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard"
  chart      = "kubernetes-dashboard"  
  version    = "2.0.1"
  namespace  = kubernetes_namespace.kubernetes_dashboard.metadata.0.name
  timeout    = 1200

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "metricsScraper.enabled"
    value = "true"
  }

  depends_on = [null_resource.wait_for_eks]
}