#!/bin/bash

kubectx docker-desktop
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update
helm install vault hashicorp/vault --atomic --set "server.dev.enabled=true"

echo
echo -n "Waiting for vault-0 pod to be ready..."
while [[ $(kubectl get pods vault-0 -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}' 2> /dev/null) != "True" ]]; do
  sleep 2
done
echo done
echo

kubectl exec -i vault-0 -- /bin/sh <<!
# Enable kv-v2 secrets at the path webgo
vault secrets enable -path=webgo kv-v2

# Create a secret at path webgo/database/config with a username and password
vault kv put webgo/database/config username="db-readonly-username" password="db-secret-password"

# Enable the Kubernetes authentication method.
vault auth enable kubernetes

# Configure the authentication to use the service account token, the location of the host, and its certificate.
vault write auth/kubernetes/config \
    token_reviewer_jwt="\$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
    kubernetes_host="https://\$KUBERNETES_PORT_443_TCP_ADDR:443" \
    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt

# Write out policy that enables the read capability for secrets at path webgo/data/database/config.
vault policy write webgo - <<EOF
path "webgo/data/database/config" {
  capabilities = ["read"]
}
EOF

# Create a Kubernetes authentication role
vault write auth/kubernetes/role/webgo \
    bound_service_account_names=webgo \
    bound_service_account_namespaces=default \
    policies=webgo \
    ttl=24h

!
