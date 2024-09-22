FROM registry.access.redhat.com/ubi9/ubi:latest

RUN echo -e "\
  alias ls='ls --color=auto'\n \
  alias ll='ls -l --color=auto'\n \
  export PS1='\n\[\e[0;1;94m\]\W \[\e[0;1;93m\]@\[\e[0;1;93m\]$(git branch 2>/dev/null | grep '"'"'^*'"'"' | colrm 1 2)\n\[\e[0;32m\]➜ \[\e[0m\]'" \
  >> /root/.bashrc

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
  GOPATH=/usr/local go clean -modcache

VOLUME ["/src"]
