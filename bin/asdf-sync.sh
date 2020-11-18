#!/bin/bash
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf install golang 1.15.3
asdf plugin-add helm https://github.com/Antiarchitect/asdf-helm.git
asdf install helm 3.3.4
asdf plugin-add helmfile https://github.com/feniix/asdf-helmfile.git
asdf install helmfile 0.134.0
asdf plugin-add istioctl https://github.com/rafik8/asdf-istioctl.git
asdf install istioctl 1.7.4
asdf plugin-add k9s https://github.com/looztra/asdf-k9s
asdf install k9s 0.22.1
asdf plugin-add kubectl https://github.com/Banno/asdf-kubectl.git
asdf install kubectl 1.19.2
asdf plugin-add kubectx https://gitlab.com/wt0f/asdf-kubectx.git
asdf install kubectx 0.9.1
