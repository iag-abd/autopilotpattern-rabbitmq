FROM rabbitmq:alpine

COPY root/ /
ADD  plugins/rabbitmq_aws-*.ez /plugins/    
ADD  plugins/autocluster-*.ez /plugins/

RUN \
  chown -R rabbitmq /usr/lib/rabbitmq /etc/rabbitmq /var/lib/rabbitmq && sync && \
  rabbitmq-plugins enable --offline \
    rabbitmq_management \
    rabbitmq_consistent_hash_exchange \
    rabbitmq_federation \
    rabbitmq_federation_management \
    rabbitmq_mqtt \
    rabbitmq_shovel \
    rabbitmq_shovel_management \
    rabbitmq_stomp \
    rabbitmq_web_stomp \
    autocluster

# Add ContainerPilot and set its configuration file path
RUN apk add --no-cache curl \
    && export CONTAINERPILOT_VER=2.7.2 \
    && export CONTAINERPILOT_CHECKSUM=e886899467ced6d7c76027d58c7f7554c2fb2bcc \
    && curl -Lso /tmp/containerpilot.tar.gz \
        "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VER}/containerpilot-${CONTAINERPILOT_VER}.tar.gz" \
    && echo "${CONTAINERPILOT_CHECKSUM}  /tmp/containerpilot.tar.gz" | sha1sum -c \
    && tar zxf /tmp/containerpilot.tar.gz -C /usr/local/bin \
    && rm /tmp/containerpilot.tar.gz

ENV CONTAINERPILOT_PATH=/etc/containerpilot/containerpilot.json
ENV CONTAINERPILOT=file://${CONTAINERPILOT_PATH}

# Override the parent entrypoint
ENTRYPOINT ["containerpilot", "docker-entrypoint.sh"]
CMD ["rabbitmq-server"]

EXPOSE 15671 15672
