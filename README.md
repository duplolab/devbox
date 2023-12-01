# Development Box

## Introduction

This guide is for setting up a complete development environment using an [Ansible Playbook](https://www.ansible.com/). It's designed for developers.

- [How to Use](#usage)
- [How to Install](#setup)
    - [Customize Your Playbook](#customize-your-playbook)
    - [Quick Install Steps](#quick-install-steps)

## <a name="usage"></a> How to Use

The "Development Box" is a ready-to-use environment for developers.

You need [ansible](https://www.ansible.com/) on your computer.

It uses Open Source software like:

- Fedora
- Homebrew on Linux
- Docker and Docker Compose
- Flatpak
- dotfiles
- tilix

It also includes client apps for app development:

- sdkman
- nvm
- tfenv

## <a name="setup"></a> How to Install

Follow the next steps to customize and set up your "Development Box".

### Customize Your Playbook

```yaml
---
##### role geerlingguy.docker
docker_users:
  - "{{ ansible_user_id }}"

##### role gantsign.sdkman
sdkman_users:
  - "{{ ansible_user_id }}"

##### role homebrew
homebrew_taps:
  - homebrew/core
  - aws/tap
homebrew_installed_packages:
  - jq
  - yq

##### dotfiles
dotfiles_repo:
  url: https://github.com/thoughtbot/dotfiles.git
  version: main
  accept_hostkey: false

##### role: unarchive_packages
unarchive_packages:
  - package_binary_dir: "{{ ansible_env.HOME }}/.local/lib/openshift-v4/clients/ocp/4.12.0/openshift-client"
    package_archive: openshift-client-linux-4.12.0.tar.gz
    package_url: https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.12.0/openshift-client-linux-4.12.0.tar.gz
    package_checksum: sha256:4523129522a89cc2c0d18e4e4c794b2409ec67b465de378616902dcacfc27860
    exclude: []
    force_install: false
    link_dir: "{{ ansible_env.HOME }}/.local/bin"
    package_bins:
      - kubectl
      - oc

##### role: flatpaks
flatpak_packages:
  - com.google.Chrome

##### tigervnc
tigervnc_username: "{{ ansible_user_id }}"
tigervnc_groupname: "{{ ansible_user_id }}"

# Connecting to tigervnc-server requires a password.
tigervnc_password: vncpass

# Use existing user's vnc paswword
tigervnc_user_exists: false

# Desktop session xstartup should connect to e.g. gnome-session, mate-session
tigervnc_desktop_session: gnome-session
```

### Quick Install Steps

To install the latest version:

On Fedora, run:

```bash
dnf -y install git ansible make findutils binutils nano distribution-gpg-keys
```

Clone the repository:

```bash
git clone https://github.com/duplolab/devbox.git
```

Install Ansible Galaxy dependencies:

```
ansible-galaxy install -r requirements.yml
ansible-galaxy collection install -r requirements.yml
```

To execute:
For workstation, desktop:

```bash
ansible-playbook -i hosts.yaml playbook-devbox-gui.yaml --ask-become-pass
```

Or for WSL, CLI only:
```bash
ansible-playbook -i hosts.yaml playbook-devbox-cli.yaml --ask-become-pass
```