# Domain 2.0 Managing, configuring, and optimizing a cluster for performance – 30% weight

* [Startup sequence; component dependencies](#startup-sequence-component-dependencies)
* [How many partitions? Tradeoffs](#how-many-partitions-tradeoffs)
* [Scalability factors](#scalability-factors)
* [Sources and tools for monitoring; Display of metrics](#sources-and-tools-for-monitoring-display-of-metrics)
* [InSyncReplicas (ISR); Fully and Under replicated, and offline](#insyncreplicas-isr-fully-and-under-replicated-and-offline)
* [Consumer lag, Under/Over Consumption](#consumer-lag-underover-consumption)
* [Broker failure, detection, and recovery](#broker-failure-detection-and-recovery)
* [Batching and its impacts/consequences](#batching-and-its-impactsconsequences)
* [Determining and solving data imbalance across brokers](#determining-and-solving-data-imbalance-across-brokers)
* [Impacts of average and maximum message sizes](#impacts-of-average-and-maximum-message-sizes)
* [Quotas](#quotas)

## Startup Sequence; Component Dependencies

1. **Zookeeper**
   - If using systemd, it requires network connectivity.
  
2. **Kafka Brokers**
   - If using systemd, it requires Zookeeper services.
   - Kafka brokers need Zookeeper to be up and running to function properly.
   - Configuration:
     - `zookeeper.connect`: `hostname1:port1,hostname2:port2,hostname3:port3/chroot/path`

## How many partitions? Tradeoffs
- `num.partitions`: This parameter specifies the number of partitions assigned to a newly created topic, particularly when automatic topic creation is enabled.
- The number of partitions for a topic can only be increased, **never** decreased.

#### How Many Partitions?
The number of partitions for a topic should be determined based on several key factors:

- **Expected Throughput**: Assess the anticipated throughput for the topic. For instance, if you aim to write 1 GB per second, you’ll need enough partitions to accommodate that.
  
- **Consumer Throughput**: Evaluate the maximum throughput per consumer from a single partition. If a consumer can only handle 50 MB per second, and you want to achieve a total throughput of 1 GB per second, you would need at least 20 partitions (1 GB ÷ 50 MB).

- **Future Needs**: Consider your potential future usage when deciding the number of partitions, especially if messages are keyed. Adding partitions later can complicate key-based routing.

- **Resource Management**: Keep in mind the resources each partition consumes on the broker, such as memory and disk space. An excessive number of partitions can increase the time for leader elections, impacting performance.

#### Trade-offs
- **Performance vs. Resource Usage**: While more partitions can improve parallelism and throughput, they also use more resources. Finding a balance is critical; overestimating your needs may strain system resources.

- **Simplicity vs. Scalability**: A lower number of partitions may simplify management and reduce resource usage, but it can also limit throughput and scalability as workload increases. 

- **Retention Policies**: Limiting the size of partitions to less than 6 GB per day of retention may help to manage performance and resource usage effectively.

By considering these factors, you can make an informed decision about the optimal number of partitions for your Kafka topic.

## Scalability Factors
- **Horizontal Scalability**: Adding more brokers to the Kafka cluster to increase capacity and throughput.
- **Vertical Scalability**: Upgrading the hardware resources of existing brokers to handle increased load.
- **Partition-Level Scalability**: Increasing the number of partitions for a topic to improve parallelism and throughput.
- **Consumer Scalability**: Scaling consumer groups to distribute the workload across multiple consumers.

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

## InSyncReplicas (ISR); Fully and Under replicated, and offline

- [Data Plane: Replication Protocol](https://developer.confluent.io/courses/architecture/data-replication/)

### Definition
- **In-Sync Replicas (ISR)**: The number of replicas for a given topic that are keeping up with the leader replica in terms of data replication.
  - `replica.lag.time.max.ms`: The maximum time a replica can lag behind the leader before it is removed from the ISR.

#### Kafka Tools command
- `kafka-replica-verification.sh`: A tool to verify the consistency of replicas in a Kafka cluster.
  - It checks the consistency of replicas by comparing the log segments of the leader and follower replicas.
  - The replica verification tool can have a significant impact on the performance of the Kafka cluster, as it consumes resources to verify the consistency of replicas.

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

## Consumer lag, Under/Over Consumption
- **Consumer Lag**: The difference between the latest offset in a Kafka topic partition and the consumer group's current offset.
- **Under-Consumption**: Occurs when consumers are unable to keep up with the rate of incoming messages.
- **Over-Consumption**: Occurs when consumers are processing messages faster than they are produced.

## Broker Failure, Detection, and Recovery

### Key Resources
- **Training Video**: [📺 Hands-On: Demonstrating Kafka Resiliency](https://www.udemy.com/course/kafka-cluster-setup/)

### Checkpoint Files
Kafka uses several **checkpoint files** to manage and **recover from failures**:

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

## Batching and its Impacts/Consequences
- **Batching**: The process of grouping multiple messages into a single batch before sending them to the Kafka broker.
- **Impacts**:
  - **Throughput**: Batching can improve throughput by reducing the number of network round trips required to send messages.
  - **Latency**: Batching can increase latency as messages are held in memory until a full batch is ready to be sent.
  - **Resource Usage**: Batching can impact resource usage, such as memory and CPU, especially when dealing with large batches.
  - **Message Ordering**: Batching can affect message ordering, as messages within a batch are processed together.
  - **Configuration**: Batching can be configured using parameters like `batch.size`, `linger.ms`, and `max.request.size`.
- **Consequences**:
  - **Increased Throughput**: Batching can improve throughput by reducing the overhead of sending individual messages.
  - **Higher Latency**: Batching can introduce additional latency as messages are held until a full batch is ready to be sent.
  - **Resource Utilization**: Batching can impact resource utilization, especially memory and CPU, depending on the batch size and frequency.
  - **Message Ordering**: Batching can affect message ordering, as messages within a batch are processed together.
  - **Configuration**: Batching parameters should be tuned based on the specific use case and requirements to achieve the desired balance between throughput, latency, and resource usage.

## Determining and Solving Data Imbalance Across Brokers
- **Data Imbalance**: When the data distribution across Kafka brokers is uneven, leading to performance issues and resource constraints.
- **Causes**:
  - **Partition Assignment**: Uneven partition assignment can result in data imbalance.
  - **Broker Failure**: If a broker fails, its partitions are reassigned to other brokers, potentially causing imbalance.
  - **Data Skew**: Uneven data distribution within partitions can lead to imbalance.
- **Solutions**:
  - **Repartitioning**: Reassign partitions to brokers to achieve a more balanced distribution.
  - **Broker Capacity**: Ensure that brokers have sufficient capacity to handle the assigned partitions.
  - **Monitoring**: Regularly monitor data distribution and rebalance as needed to maintain balance.
- **Impact**:
  - **Performance**: Data imbalance can lead to performance degradation due to uneven resource utilization.
  - **Resource Utilization**: Imbalance can strain resources on some brokers while underutilizing others.
  - **Reliability**: Data imbalance can impact reliability and availability if brokers are overloaded or underutilized.
- **Mitigation**:
  - **Monitoring**: Regularly monitor data distribution and broker utilization to identify imbalances.
  - **Rebalancing**: Reassign partitions to brokers to achieve a more even distribution.
  - **Capacity Planning**: Ensure that brokers have sufficient capacity to handle the assigned partitions.

## Impacts of Average and Maximum Message Sizes
- **Average Message Size**: The average size of messages produced and consumed by Kafka.
- **Maximum Message Size**: The maximum size of messages that can be produced and consumed by Kafka.
- **Impacts**:
  - **Throughput**: Larger message sizes can impact throughput due to increased network and disk I/O.
  - **Latency**: Larger messages can increase latency, especially if they need to be split across multiple segments.
  - **Resource Usage**: Larger messages consume more memory and disk space, impacting resource utilization.
  - **Configuration**: Parameters like `message.max.bytes` and `replica.fetch.max.bytes` can be used to control message size.
- **Consequences**:
  - **Throughput**: Large messages can reduce throughput due to increased network and disk I/O.
  - **Latency**: Large messages can increase latency, especially if they need to be split across multiple segments.
  - **Resource Utilization**: Large messages consume more memory and disk space, impacting resource utilization.
  - **Configuration**: Message size parameters should be tuned based on the specific use case and requirements to achieve the desired balance between throughput, latency, and resource usage.
- **Considerations**:
  - **Network Bandwidth**: Larger messages consume more network bandwidth, impacting throughput.
  - **Disk Space**: Large messages require more disk space, affecting storage capacity.
  - **Segmentation**: Large messages may need to be segmented into smaller chunks for storage and replication.
  - **Performance**: Large messages can impact performance due to increased I/O and resource consumption.

## Quotas

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

