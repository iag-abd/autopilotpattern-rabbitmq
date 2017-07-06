RabbitMQ-Autoclsuter Consul example
--
Dynamic RabbitMQ cluster using:

1. [Docker compose](https://docs.docker.com/compose/)

2. [Consul](https://www.consul.io) 

3. [HA proxy](https://github.com/docker/dockercloud-haproxy)


Execute
--
```
docker build -t rabbitmq/rabbitmq-autocluster .
docker-compose up
docker-compose scale rabbit=3
```
or run `./build_local.sh`

Check
--

- Consul Management: http://localhost:8500/ui/ 
- RabbitMQ Management: http://localhost:15672/#/
