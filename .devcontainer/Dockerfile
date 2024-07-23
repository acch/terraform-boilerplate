FROM registry.access.redhat.com/ubi9/ubi:latest

RUN echo -e "\
  alias ls='ls --color=auto'\n\
  alias ll='ls -l --color=auto'\n" \
  >> /root/.bashrc

RUN dnf -y update && \
  dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm && \
  /usr/bin/crb enable && \
  sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin && \
  dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo && \
  dnf -y install \
    git \
    golang \
    yamllint \
    terraform && \
  dnf clean all && \
  GOPATH=/usr/local go install github.com/terraform-docs/terraform-docs@v0.17.0 && \
  GOPATH=/usr/local go clean -modcache

VOLUME ["/src"]
