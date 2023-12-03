set -eux;

dnf -y install git ansible make findutils binutils nano distribution-gpg-keys

ansible-galaxy install -r requirements.yml

ansible-playbook -i hosts.yaml playbook-devbox-gui.yaml --ask-become-pass