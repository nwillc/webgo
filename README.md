# WEBGO

This is just experiments with:

 - Go (v1.15.1)
 - Kubernetes (OSX Docker Desktop)
 - Helm (v2.9.0+, v3.+)
    - environment yaml files to env variables 
    - environment global with local overrides
 - Vault
 
## Basic Steps
 
```bash
# Install vault and configure a secret for k8s to use
./bin/vault-install.sh
# Build the docker image, deploy to repo, Helm deploy to k8s
# helm deploy 
./bin/deploy.sh -b -n NAME -v VERSION
```

## Config Notes
Environment variables are exposed to the service from YAML files in `environment` folder. The YAML, containing a map named
`config` is mapped to environment variables as follows:

```yaml
config:
    max: "42"
    database:
      name: "server.name.com"
      port: "2056"
``` 

The environment variables that result will be:

```bash
CONFIG_MAX=42
CONFIG_DATABASE_NAME=server.name.com
CONFIG_DATABASE_PORT=2056
```


## Notes:
 
