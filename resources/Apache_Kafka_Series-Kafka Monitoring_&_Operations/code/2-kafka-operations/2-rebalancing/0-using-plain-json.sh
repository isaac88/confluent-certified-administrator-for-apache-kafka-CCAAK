export ZK_HOST="172.31.9.21:2181"
export KAFKA_HOST="172.31.33.33:9092"

# create a kafka topic with 2 partition and 2 RF
bin/kafka-topics.sh --zookeeper $ZK_HOST --create --topic second_topic --partitions 2 --replication-factor 2

# describe to see the partition assignment
bin/kafka-topics.sh --zookeeper $ZK_HOST --describe --topic second_topic

# Example:
# Topic:second_topic	PartitionCount:2	ReplicationFactor:2	Configs:
# 	Topic: second_topic	Partition: 0	Leader: 2	Replicas: 2,3	Isr: 2,3
# 	Topic: second_topic	Partition: 1	Leader: 3	Replicas: 3,1	Isr: 3,1

# Produce some messages
bin/kafka-console-producer.sh --broker-list $KAFKA_HOST --topic second_topic

# Consume the messages
bin/kafka-console-consumer.sh --bootstrap-server $KAFKA_HOST --topic second_topic --from-beginning

# Create an assignment
nano topics.json
bin/kafka-reassign-partitions.sh --zookeeper $ZK_HOST  --topics-to-move-json-file topics.json --broker-list "1,2,3" --generate

# copy the proposed assignment into a file:
nano reassignment.json
bin/kafka-reassign-partitions.sh --zookeeper $ZK_HOST --reassignment-json-file reassignment.json --execute

# verify the status
bin/kafka-reassign-partitions.sh --zookeeper $ZK_HOST --reassignment-json-file reassignment.json --verify

# describe topic:
bin/kafka-topics.sh --zookeeper $ZK_HOST --describe --topic second_topic

# run preferred replica election 
bin/kafka-preferred-replica-election.sh --zookeeper $ZK_HOST

# describe topic
bin/kafka-topics.sh --zookeeper $ZK_HOST --describe --topic second_topic

# Consume the messages
bin/kafka-console-consumer.sh --bootstrap-server $KAFKA_HOST --topic second_topic --from-beginning


