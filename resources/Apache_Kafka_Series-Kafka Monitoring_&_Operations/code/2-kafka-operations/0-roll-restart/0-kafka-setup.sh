########
#### KAFKA MACHINE
########
# download jolokia agent:
cd
mkdir jolokia
cd jolokia
wget http://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-jvm/1.6.0/jolokia-jvm-1.6.0-agent.jar -O jolokia-agent.jar

# Edit /etc/systemd/system/kafka.service
# Environment="KAFKA_OPTS=-javaagent:/home/ec2-user/prometheus/jmx_prometheus_javaagent-0.3.1.jar=8080:/home/ec2-user/prometheus/kafka-0-8-2.yml -javaagent:/home/ec2-user/jolokia/jolokia-agent.jar=host=*"

# restart Kafka
sudo systemctl daemon-reload
sudo systemctl restart kafka

# Test jolokia
sudo yum install -y jq
curl localhost:8778/jolokia/read/kafka.server:type=KafkaRequestHandlerPool,name=RequestHandlerAvgIdlePercent | jq

curl localhost:8778/jolokia/read/kafka.server:name=UnderReplicatedPartitions,type=ReplicaManager/Value | jq

# do the same on broker 2 and 3