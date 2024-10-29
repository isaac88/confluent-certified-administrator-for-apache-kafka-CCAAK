# Domain 2.0 Managing, configuring, and optimizing a cluster for performance – 30% weight

* [Startup sequence; component dependencies](#startup-sequence-component-dependencies)
* How many partitions? Tradeoffs
* Scalability factors
* [Sources and tools for monitoring; Display of metrics](#sources-and-tools-for-monitoring-display-of-metrics)
* InSyncReplicas (ISR); Fully and Under replicated, and offline
* Consumer lag, Under/Over Consumption
* [Broker failure, detection, and recovery](#broker-failure-detection-and-recovery)
* Batching and its impacts/consequences
* Determining and solving data imbalance across brokers
* Impacts of average and maximum message sizes
* Quotas

## Startup sequence; component dependencies

1. Zookeeper
    - If systemd, it's requires network
2. Kafka Brokers
    - If systemd, it's requires zookeeper.services
    - Kafka brokers needs to have Zookeeper up and running to works. 
    - `zookeeper.connect`: hostname1:port1,hostname2:port2,hostname3:port3/chroot/path

## Sources and tools for monitoring; Display of metrics

## Broker failure, detection, and recovery

* [📺 35. Hands-On: Demonstrating Kafka Resiliency ](https://www.udemy.com/course/kafka-cluster-setup/)
* `cleaner-offset-checkpoint`: Where Kafka checkpoints the last cleaned offset of all topic partitions. It is used to compute the dirtyRatio of inactive segments prior to log compaction. The file format is <topic-name> <partition number> <offset>
* `recovery-point-offset-checkpoint`: Where Kafka tracks which messages (from-to offset) were successfully flushed to disk for each topic partition.
* `replication-offset-checkpooint`: Where Kafka tracks which messages (from-to offset) were successfully replicated to other brokers for each topic partition. It’s like an offset high water mark of the last committed, replicated message.
* `meta.properties`: Where Kafka checkpoints the latest cluster and broker metadata like clusterId and brokerId.
* `log-start-offset-checkpoint`: Where Kafka tracks the first/earliest offset of each topic partition.

## Quotas

- [Quotas](https://kafka.apache.org/documentation/#design_quotas)
- Set Quotas to avoid spikes of usage by de clients producers/consumers (DOS).
- Network bandwidth quotas: define byte-rate thresholds
- Request rate quotas: define CPU utilization thresholds as a percentage of network and I/O threads
