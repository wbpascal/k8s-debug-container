#!/bin/bash
# This script prepares necessary data before starting the SSH server

# Point to the internal API server hostname
APISERVER=https://kubernetes.default.svc

# Path to ServiceAccount token
SERVICEACCOUNT=/var/run/secrets/kubernetes.io/serviceaccount

# Read this Pod's namespace
NAMESPACE=$(cat ${SERVICEACCOUNT}/namespace)

# Read the ServiceAccount bearer token
TOKEN=$(cat ${SERVICEACCOUNT}/token)

# Reference the internal certificate authority (CA)
CACERT=${SERVICEACCOUNT}/ca.crt

# Setup kubectl config and context
kubectl config set-cluster cfc --server=${APISERVER} --certificate-authority=${CACERT}
kubectl config set-context cfc --cluster=cfc
kubectl config set-credentials user --token=${TOKEN}
kubectl config set-context cfc --user=user
kubectl config use-context cfc

# Start SSH server and propagate args to it
/init "$@"