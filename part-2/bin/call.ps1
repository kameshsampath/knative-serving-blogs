
$IpAddress = kubectl get node -o 'jsonpath={.items[0].status.addresses[0].address}'
$NodePort  = kubectl get svc knative-ingressgateway -n istio-system -o 'jsonpath={.spec.ports[?@.port==80)].nodePort}'
$HostUrl   =  kubectl get  routes.serving.knative.dev customer  -o jsonpath='{.status.domain}'

Write-Host: "Calling Service ${HostUrl}: http://${IpAddress}:${NodePort}"
curl -H "Host: ${HostUrl}" "http://${IpAddress}:${NodePort}"