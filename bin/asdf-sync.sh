#!/bin/bash
asdf plugin-add helm https://github.com/Antiarchitect/asdf-helm.git
asdf install helm 3.3.4
asdf plugin-add istioctl https://github.com/rafik8/asdf-istioctl.git
asdf install istioctl 1.7.4
asdf plugin-add kubectl https://github.com/Banno/asdf-kubectl.git
asdf install kubectl 1.19.2
asdf plugin-add kubectx https://gitlab.com/wt0f/asdf-kubectx.git
asdf install kubectx 0.9.1
