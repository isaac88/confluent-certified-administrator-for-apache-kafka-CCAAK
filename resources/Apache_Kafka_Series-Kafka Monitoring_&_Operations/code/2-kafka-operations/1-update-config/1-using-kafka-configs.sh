# source of code and full documentation is here:
# https://kafka.apache.org/documentation/#dynamicbrokerconfigs

KAFKA_HOST=172.31.33.33:9092

# To alter the current broker configs for broker id 1 (for example, the number of log cleaner threads):
bin/kafka-configs.sh --bootstrap-server $KAFKA_HOST --entity-type brokers --entity-name 1 --alter --add-config log.cleaner.threads=2

# To describe the current dynamic broker configs for broker id 1:
bin/kafka-configs.sh --bootstrap-server $KAFKA_HOST --entity-type brokers --entity-name 1 --describe

# To delete a config override and revert to the statically configured or default value for broker id 1 (for example, the number of log cleaner threads):
bin/kafka-configs.sh --bootstrap-server $KAFKA_HOST --entity-type brokers --entity-name 1 --alter --delete-config log.cleaner.threads

# Some configs may be configured as a cluster-wide default to maintain consistent values across the whole cluster. All brokers in the cluster will process the cluster default update. For example, to update log cleaner threads on all brokers:
bin/kafka-configs.sh --bootstrap-server $KAFKA_HOST --entity-type brokers --entity-default --alter --add-config log.cleaner.threads=2

# To describe the currently configured dynamic cluster-wide default configs:
bin/kafka-configs.sh --bootstrap-server $KAFKA_HOST --entity-type brokers --entity-default --describe

