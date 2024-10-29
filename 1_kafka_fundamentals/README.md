# 1.0 Kafka fundamentals 15% weight

* Apache Kafka architecture, design principles, and purposes
* [Distributed Systems - Scalability, Fault Tolerance, High Availability](#distributed-systems---scalability-fault-tolerance-high-availability)
* Primary functions of: Producer, Consumer, Broker
* Meaning of “immutable” log
* Meaning of “committed”
* Topics, Partitions
* Essential services of Apache Zookeeper
* Replication, Leaders, Followers
* Kafka Messages, structure, make-up, metadata
* Kafka Controller
* Exactly Once Semantics

## Distributed Systems - Scalability, Fault Tolerance, High Availability

## 1. Scalability in Kafka
### Definition
- **Scalability** in Kafka refers to the ability of the Kafka cluster to handle increased loads by adding more brokers, topics, or partitions.

### Key Concepts
- **Topic Partitioning**:
  - Kafka topics are divided into partitions, allowing for parallel processing and increased throughput.
  - Each partition can be replicated across multiple brokers for fault tolerance.

- **Horizontal Scalability**:
  - Adding more brokers to a Kafka cluster increases the capacity to handle more partitions and consumers.
  - Producers and consumers can be scaled independently based on their load.

### Best Practices for Scalability
- **Partition Count**: Choose an optimal number of partitions for a topic based on expected load and consumer parallelism.
- **Consumer Groups**: Utilize consumer groups to distribute the load among multiple consumers, allowing them to read from different partitions simultaneously.

## 2. Fault Tolerance in Kafka
### Definition
- **Fault Tolerance** in Kafka ensures that the system continues to operate correctly even in the event of broker failures or other component failures.

### Key Concepts
- **Replication**:
  - Each partition can be configured with a replication factor, which defines how many copies of the partition exist across different brokers.
  - If a broker fails, other brokers with replicas can take over, ensuring data availability.

- **In-Sync Replicas (ISR)**:
  - Replicas that are fully caught up with the leader are part of the ISR.
  - Kafka will only accept writes if the number of in-sync replicas meets the `min.insync.replicas` configuration.

### Best Practices for Fault Tolerance
- **Set Appropriate Replication Factors**: Use a replication factor of at least 3 for production environments to ensure high availability and fault tolerance.
- **Monitor ISR**: Regularly monitor the ISR to ensure that replicas are in sync with the leader.

## 3. High Availability in Kafka
### Definition
- **High Availability** in Kafka ensures that the system remains accessible and operational with minimal downtime.

### Key Concepts
- **Broker Redundancy**:
  - Deploy multiple brokers in a Kafka cluster to prevent a single point of failure.
  - Use rack awareness to spread replicas across different racks or availability zones.

- **Automatic Leader Election**:
  - Kafka automatically elects a new leader for a partition if the current leader fails, ensuring continued availability.

### Best Practices for High Availability
- **Cluster Monitoring**: Implement monitoring tools (e.g., Confluent Control Center, Prometheus) to track the health and performance of the Kafka cluster.
- **Configuration Tuning**: Optimize configurations such as `unclean.leader.election.enable` to control how leader elections are handled during broker failures.
