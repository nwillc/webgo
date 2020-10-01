#!/bin/bash

kubectx docker-desktop
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update
helm install vault hashicorp/vault --set "server.dev.enabled=true"

sleep 10
kubectl exec -it vault-0 -- /bin/sh <<!
# Enable kv-v2 secrets at the path internal
vault secrets enable -path=internal kv-v2
# Create a secret at path internal/database/config with a username and password
vault kv put internal/database/config username="db-readonly-username" password="db-secret-password"
# Enable the Kubernetes authentication method.
vault auth enable kubernetes
# Configure the authentication to use the service account token, the location of the host, and its certificate.
vault write auth/kubernetes/config \
    token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
    kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
# Write out policy that enables the read capability for secrets at path internal/data/database/config.
vault policy write webgo-app - <<EOF
path "internal/data/database/config" {
  capabilities = ["read"]
}
EOF
# Create a Kubernetes authentication role
vault write auth/kubernetes/role/webgo-app \
    bound_service_account_names=webgo-app \
    bound_service_account_namespaces=default \
    policies=webgo-app \
    ttl=24h
!
