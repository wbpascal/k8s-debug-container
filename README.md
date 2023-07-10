# k8s-debug-container
A container which contains an OpenSSH server in addition to Kubernetes tools that can be used to remote debug without local kubectl access. Mainly used when ArgoCD or similar is deployed but it is necessary to debug a container more closely without having access to the Kubernetes cluster using kubectl on the local machine. A service account with the necessary rights is still required to fully use the features of this container. The service account is automatically configured to be used by the included programs on start.

Build on top of [linuxserver/openssh-server](https://hub.docker.com/r/linuxserver/openssh-server)

## Additionally installed tools

* kubectl (latest during build-time, including auto-completion)
* k9s (latest during build-time)
* kubeseal (latest during build-time)
