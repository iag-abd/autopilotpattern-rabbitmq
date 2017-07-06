docker build --no-cache -t rabbitmq/rabbitmq-autocluster . 
[[ $? != 0 ]] && exit 1
docker-compose up -d
sleep 10
docker-compose scale rabbit=3
