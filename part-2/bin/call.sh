#!/bin/bash 

set -e 

export IP_ADDRESS=$(minishift ip):$(oc get svc knative-ingressgateway -n istio-system -o 'jsonpath={.spec.ports[?(@.port==80)].nodePort}')
export HOST_URL=$(kubectl get routes.serving.knative.dev customer -o jsonpath='{.status.domain}')

curl -m 30 -H "Host: ${HOST_URL}" http://${IP_ADDRESS}/