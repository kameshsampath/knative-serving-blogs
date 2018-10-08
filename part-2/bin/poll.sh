#!/bin/bash 

set -e 

export K_NODE_PORT=$(oc get svc knative-ingressgateway -n istio-system -o 'jsonpath={.spec.ports[?(@.port==80)].nodePort}')
export IP_ADDRESS=$(minishift ip)
export HOST_URL=$(kubectl get  routes.serving.knative.dev customer  -o jsonpath='{.status.domain}')

while true
 do
   curl -H "Host:${HOST_URL}"http://${IP_ADDRESS}:${K_NODE_PORT}
   sleep .2
 done;