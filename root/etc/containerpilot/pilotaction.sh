#!/bin/sh

function preStart() {
  echo "preStart"
    # consul-template \
    #     -once \
    #     -consul consul:8500 \
    #     -template "/etc/containerpilot/nginx.conf.ctmpl:/etc/nginx/nginx.conf"
}

function postStop() {
  CONSUL_HOST=$1
  echo curl "${CONSUL_HOST}/v1/agent/service/deregister/${CONSUL_SVC}:${HOSTNAME}"
  curl "${CONSUL_HOST}/v1/agent/service/deregister/${CONSUL_SVC}:${HOSTNAME}"
}

# Render Nginx configuration template using values from Consul,
# then gracefully reload Nginx
function onChange() {
  echo "onChange"
    # consul-template \
    #     -once \
    #     -consul consul:8500 \
    #     -template "/etc/containerpilot/nginx.conf.ctmpl:/etc/nginx/nginx.conf:nginx -s reload"
}

cmd=$1
shift 1
$cmd "$@"
exit

# until
#     cmd=$1
#     if [ -z "$cmd" ]; then
#         onChange
#     fi
#     shift 1
#     $cmd "$@"
#     [ "$?" -ne 127 ]
# do
#     onChange
#     exit
# done