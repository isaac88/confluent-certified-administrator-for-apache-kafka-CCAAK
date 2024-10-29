# Documentation for set-replication-factor module: https://github.com/linkedin/kafka-tools/wiki/module-set-replication-factor


# describe topic:
bin/kafka-topics.sh --zookeeper $ZK_HOST --describe --topic third_topic

# test an assigner
kafka-assigner  -z $ZK_HOST --generate set-replication-factor --topic third_topic --replication-factor 3
# execute an assignment
kafka-assigner  -z $ZK_HOST -e set-replication-factor --topic third_topic --replication-factor 3


# describe topic:
bin/kafka-topics.sh --zookeeper $ZK_HOST --describe --topic third_topic

# we can even decrease the replication factor!
kafka-assigner  -z $ZK_HOST -e set-replication-factor --topic third_topic --replication-factor 1

# describe topic:
bin/kafka-topics.sh --zookeeper $ZK_HOST --describe --topic third_topic
