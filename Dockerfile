FROM linuxserver/openssh-server:latest

ARG KUBESEAL_VERSION=0.22.0

# Update apk package index
RUN apk update

# Add pre-requirements
RUN apk add bash-completion 
RUN mkdir -p /etc/bash_completion.d

# Add tools that can be found as apk packages
RUN apk add k9s k9s-bash-completion

# Install kubectl
RUN curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o kubectl
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
RUN kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null && \
    chmod a+r /etc/bash_completion.d/kubectl

# Install kubeseal
RUN wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v$KUBESEAL_VERSION/kubeseal-$KUBESEAL_VERSION-linux-amd64.tar.gz && \
    tar -xvzf kubeseal-$KUBESEAL_VERSION-linux-amd64.tar.gz kubeseal && \
    install -m 755 kubeseal /usr/local/bin/kubeseal

# Change ash to bash as default shell
RUN sed 's/\/ash$/\/bash/g' /etc/passwd

ADD entrypoint.sh /run/entrypoint.sh

ENTRYPOINT ["/run/entrypoint.sh"]