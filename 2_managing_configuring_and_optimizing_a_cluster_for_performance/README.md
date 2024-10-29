# Domain 2.0 Managing, configuring, and optimizing a cluster for performance – 30% weight

* [Startup sequence; component dependencies](#startup-sequence-component-dependencies)
* How many partitions? Tradeoffs
* Scalability factors
* [Sources and tools for monitoring; Display of metrics](#sources-and-tools-for-monitoring-display-of-metrics)
* [InSyncReplicas (ISR); Fully and Under replicated, and offline](#insyncreplicas-isr-fully-and-under-replicated-and-offline)
* Consumer lag, Under/Over Consumption
* [Broker failure, detection, and recovery](#broker-failure-detection-and-recovery)
* Batching and its impacts/consequences
* Determining and solving data imbalance across brokers
* Impacts of average and maximum message sizes
* Quotas

## Startup Sequence; Component Dependencies

1. **Zookeeper**
   - If using systemd, it requires network connectivity.
  
2. **Kafka Brokers**
   - If using systemd, it requires Zookeeper services.
   - Kafka brokers need Zookeeper to be up and running to function properly.
   - Configuration:
     - `zookeeper.connect`: `hostname1:port1,hostname2:port2,hostname3:port3/chroot/path`

## Sources and Tools for Monitoring; Display of Metrics

### Broker Monitoring
- **Documentation**: [Kafka Broker Monitoring](https://kafka.apache.org/documentation/#monitoring)
- **Metrics Reporting**:
  - Kafka uses Yammer Metrics for metrics reporting on the server.
  - Metrics are exposed via JMX (Java Management Extensions).
  - Remote JMX is disabled by default in Apache Kafka.
  - JMX can be configured to report statistics using pluggable stats reporters (e.g., Prometheus).
  
- **Monitoring Tools**:
  - **JConsole**: A GUI tool for monitoring Java applications via JMX.
  - **Recommended Metrics**:
    - **General Server Stats**:
      - GC (Garbage Collection) time
      - CPU utilization
      - I/O service time
    - **Client Metrics**:
      - Message/byte rate (global and per topic)
      - Request rate, size, and time
    - **Consumer Metrics**:
      - Maximum lag in messages among all partitions
      - Minimum fetch request rate
      - Maximum lag should be less than a predefined threshold.
      - Minimum fetch rate should be greater than 0.

### Zookeeper Monitoring
- **Documentation**: [Zookeeper Monitoring](https://zookeeper.apache.org/doc/current/zookeeperMonitor.html)
- **Monitoring Tools**:
  - [JMX for Zookeeper](https://zookeeper.apache.org/doc/current/zookeeperJMX.html)
  - Prometheus
  - Grafana
  - InfluxDB

### Administration and Monitoring Tools
- **Administration**:
  - **CMAK (Cluster Manager for Apache Kafka)**: Previously known as Kafka Manager, it's a tool for managing Apache Kafka clusters.
  - **ZooNavigator**: A web-based ZooKeeper UI, editor, and browser with numerous features.

- **Monitoring**:
  - [Kafka Monitor](https://github.com/linkedin/kafka-monitor): A framework for implementing and executing long-running Kafka system tests in a real cluster.

## In-Sync Replicas (ISR)

### Definition
- **In-Sync Replicas (ISR)**: The number of replicas for a given topic that are keeping up with the leader replica in terms of data replication.

### Replica States
- **Fully Replicated**: 
  - All replicas (leader and followers) are up to date.
  - Replication is functioning correctly, ensuring data availability.
  
- **Under-Replicated**: 
  - A partition is considered under-replicated if the correct number of replicas exists, but one or more followers have fallen significantly behind the leader.
  - This indicates potential issues with data synchronization.

### Availability and Integrity
- Even when replicas on a failed broker are unavailable, Kafka maintains data availability and integrity through replication across other brokers.
- As long as there are enough in-sync replicas (ISRs) available, Kafka can continue to serve read and write operations for the affected partitions.

### Write Operations
- If the number of in-sync replicas falls below the configured `min.insync.replicas` setting:
  - Kafka will stop accepting writes to the affected partitions.
  - This mechanism is in place to prevent data loss and ensure consistency across replicas.

## Broker Failure, Detection, and Recovery

### Key Resources
- **Training Video**: [📺 Hands-On: Demonstrating Kafka Resiliency](https://www.udemy.com/course/kafka-cluster-setup/)

### Checkpoint Files
Kafka uses several checkpoint files to manage and recover from failures:

1. **cleaner-offset-checkpoint**:
   - Stores the last cleaned offset of all topic partitions.
   - Used to compute the `dirtyRatio` of inactive segments prior to log compaction.
   - File format: `<topic-name> <partition number> <offset`.

2. **recovery-point-offset-checkpoint**:
   - Tracks which messages (from-to offset) were successfully flushed to disk for each topic partition.

3. **replication-offset-checkpoint**:
   - Monitors which messages (from-to offset) were successfully replicated to other brokers for each topic partition.
   - Acts as an offset high watermark for the last committed, replicated message.

4. **meta.properties**:
   - Contains the latest cluster and broker metadata, including `clusterId` and `brokerId`.

5. **log-start-offset-checkpoint**:
   - Records the first/earliest offset of each topic partition.

### Summary
These checkpoint files play a critical role in ensuring data integrity and facilitating recovery processes in the event of broker failures. They help Kafka manage offsets, replication, and metadata effectively, ensuring that the system can recover gracefully from failures.

## Quotas in Kafka

- **Documentation**: [Kafka Quotas](https://kafka.apache.org/documentation/#design_quotas)

### Purpose of Quotas
- Quotas are used to prevent spikes in usage by client producers and consumers, which can lead to denial-of-service (DoS) situations.
  
### Types of Quotas
1. **Network Bandwidth Quotas**:
   - Define thresholds for byte-rate usage.
   - Help manage and limit the amount of data transmitted over the network to ensure fair usage among clients.

2. **Request Rate Quotas**:
   - Define CPU utilization thresholds as a percentage of network and I/O threads.
   - Control the rate of requests that clients can make to the Kafka brokers, ensuring that no single client can overwhelm the system.

### Summary
Implementing quotas in Kafka is crucial for maintaining performance and stability, allowing for fair resource allocation among multiple clients and preventing potential overload scenarios.

