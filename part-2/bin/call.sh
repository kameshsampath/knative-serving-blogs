#!/bin/bash 

set -e 

export IP_ADDRESS=$(minishift ip):$(oc get svc knative-ingressgateway -n istio-system -o 'jsonpath={.spec.ports[?(@.port==80)].nodePort}')
export HOST_URL=$(kubectl get  routes.serving.knative.dev greeter -o jsonpath='{.status.domain}')

while true
do
  curl -H "Host: ${HOST_URL}" http://${IP_ADDRESS}
  echo ""
  sleep .2
done;
