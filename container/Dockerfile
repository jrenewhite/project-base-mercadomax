FROM ubuntu:24.04

ARG TARGETARCH

ENV DEBIAN_FRONTEND=noninteractive
ENV POWERSHELL_TELEMETRY_OPTOUT=1
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    libicu74 \
    locales \
    git \
    gpg \
    openssh-server \
    postgresql-client \
    python3 \
    tar \
    sudo \
  && sed -i 's/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && locale-gen en_US.UTF-8 \
  && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
  && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
  case "$TARGETARCH" in \
    amd64) pwsh_arch='x64' ;; \
    arm64) pwsh_arch='arm64' ;; \
    *) echo "Unsupported architecture: $TARGETARCH" >&2; exit 1 ;; \
  esac; \
  release_tag="$(curl -fsSL https://api.github.com/repos/PowerShell/PowerShell/releases/latest | sed -n 's/.*"tag_name": "\([^"]*\)".*/\1/p' | head -n1)"; \
  test -n "$release_tag"; \
  version="${release_tag#v}"; \
  curl -fsSL -o /tmp/powershell.tar.gz "https://github.com/PowerShell/PowerShell/releases/download/${release_tag}/powershell-${version}-linux-${pwsh_arch}.tar.gz"; \
  mkdir -p /opt/microsoft/powershell/7; \
  tar -xzf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7; \
  ln -sfn /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh; \
  rm -f /tmp/powershell.tar.gz

RUN useradd -m -s /bin/bash developer \
  && echo "developer:developer" | chpasswd \
  && usermod -aG sudo developer \
  && mkdir -p /var/run/sshd /workspace/session \
  && chown -R developer:developer /workspace/session /home/developer

RUN printf "PasswordAuthentication yes\nPermitRootLogin no\nUsePAM no\n" >> /etc/ssh/sshd_config

RUN printf '%s\n' \
    '#!/usr/bin/env bash' \
    'if [[ $- == *i* ]] && [[ -x /workspace/session/scripts/connection-info.sh ]]; then' \
    '  SCRIPT_PATH=/workspace/session/scripts/connection-info.sh bash -s -- < <(tr -d '"'"'\r'"'"' < /workspace/session/scripts/connection-info.sh)' \
    'fi' \
    > /etc/profile.d/project-base-mercadomax-connection-info.sh

RUN printf '\nif [ -f /etc/profile.d/project-base-mercadomax-connection-info.sh ]; then . /etc/profile.d/project-base-mercadomax-connection-info.sh; fi\n' >> /etc/bash.bashrc

RUN printf '%s\n' \
    '#!/usr/bin/env bash' \
    'connection-info() {' \
    '  SCRIPT_PATH=/workspace/session/scripts/connection-info.sh bash -s -- "$@" < <(tr -d '"'"'\r'"'"' < /workspace/session/scripts/connection-info.sh)' \
    '}' \
    '' \
    'check() {' \
    '  SCRIPT_PATH=/workspace/session/scripts/run-sanity-check.sh bash -s -- "$@" < <(tr -d '"'"'\r'"'"' < /workspace/session/scripts/run-sanity-check.sh)' \
    '}' \
    '' \
    'sanity-check() {' \
    '  SCRIPT_PATH=/workspace/session/scripts/run-sanity-check.sh bash -s -- "$@" < <(tr -d '"'"'\r'"'"' < /workspace/session/scripts/run-sanity-check.sh)' \
    '}' \
    > /etc/profile.d/project-base-mercadomax-shortcuts.sh

RUN printf '\nif [ -f /etc/profile.d/project-base-mercadomax-shortcuts.sh ]; then . /etc/profile.d/project-base-mercadomax-shortcuts.sh; fi\n' >> /etc/bash.bashrc

RUN printf '%s\n' \
    'if (Test-Path /workspace/session/scripts/connection-info.ps1) {' \
    '  & /workspace/session/scripts/connection-info.ps1' \
    '}' \
    'function connection-info {' \
    '  & /workspace/session/scripts/connection-info.ps1 @Args' \
    '}' \
    'function check {' \
    '  & /workspace/session/scripts/run-sanity-check.ps1 @Args' \
    '}' \
    'function sanity-check {' \
    '  & /workspace/session/scripts/run-sanity-check.ps1 @Args' \
    '}' \
    > /opt/microsoft/powershell/7/profile.ps1

WORKDIR /workspace/session

EXPOSE 22

CMD ["/bin/bash", "-lc", "mkdir -p /var/run/sshd && /usr/sbin/sshd && tail -f /dev/null"]
