export ZK_HOST="172.31.9.21:2181"
export KAFKA_HOST="172.31.33.33:9092"

# create a kafka topic with 2 partition and 2 RF
bin/kafka-topics.sh --zookeeper $ZK_HOST --create --topic third_topic --partitions 3 --replication-factor 1

# describe to see the partition assignment
bin/kafka-topics.sh --zookeeper $ZK_HOST --describe --topic third_topic

# Topic:third_topic	PartitionCount:3	ReplicationFactor:1	Configs:
# 	Topic: third_topic	Partition: 0	Leader: 2	Replicas: 2	Isr: 2
# 	Topic: third_topic	Partition: 1	Leader: 3	Replicas: 3	Isr: 3
# 	Topic: third_topic	Partition: 2	Leader: 1	Replicas: 1	Isr: 1

# Produce some messages
bin/kafka-console-producer.sh --broker-list $KAFKA_HOST --topic third_topic

# Consume the messages
bin/kafka-console-consumer.sh --bootstrap-server $KAFKA_HOST --topic third_topic --from-beginning

# Create an assignment
nano topics.json
bin/kafka-reassign-partitions.sh --zookeeper $ZK_HOST  --topics-to-move-json-file topics.json --broker-list "1,2,3" --generate

# modify, then copy the proposed assignment into a file:
nano reassignment_third_topic.json
bin/kafka-reassign-partitions.sh --zookeeper $ZK_HOST --reassignment-json-file reassignment_third_topic.json --execute

# verify the status
bin/kafka-reassign-partitions.sh --zookeeper $ZK_HOST --reassignment-json-file reassignment_third_topic.json --verify

# describe topic:
bin/kafka-topics.sh --zookeeper $ZK_HOST --describe --topic third_topic

# run preferred replica election 
bin/kafka-preferred-replica-election.sh --zookeeper $ZK_HOST

# describe topic
bin/kafka-topics.sh --zookeeper $ZK_HOST --describe --topic third_topic

# Consume the messages
bin/kafka-console-consumer.sh --bootstrap-server $KAFKA_HOST --topic third_topic --from-beginning


