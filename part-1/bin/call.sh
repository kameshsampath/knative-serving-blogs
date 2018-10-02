#!/bin/bash 

set -e 

export IP_ADDRESS=$(kubectl get node -o 'jsonpath={.items[0].status.addresses[0].address}'):$(oc get svc knative-ingressgateway -n istio-system -o 'jsonpath={.spec.ports[?(@.port==80)].nodePort}')
export HOST_URL=$(kubectl get  routes.serving.knative.dev greeter  -o jsonpath='{.status.domain}')

curl -H "Host: ${HOST_URL}" http://${IP_ADDRESS}