FROM registry.access.redhat.com/ubi9/ubi:latest

ARG PS1A="'\n\[\e[0;1;94m\]\W \[\e[0;1;93m\]@\[\e[0;1;93m\]$(git branch --show-current 2>/dev/null)\n\[\e[0;32m\]➜ \[\e[0m\]'"
RUN cat <<EOF >> /root/.bashrc
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -la --color=auto'
PS1=$PS1A
export PATH=$PATH:/usr/local/go/bin
EOF

RUN dnf -y update && \
  dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm && \
  /usr/bin/crb enable && \
  dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo && \
  dnf -y install \
    git \
    golang \
    yamllint \
    terraform && \
  dnf clean all && \
  sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin && \
  GOPATH=/usr/local go install github.com/terraform-docs/terraform-docs@v0.17.0 && \
  GOPATH=/usr/local go install github.com/AlexNabokikh/tfsort@latest && \
  GOPATH=/usr/local go clean -modcache

VOLUME ["/src"]
