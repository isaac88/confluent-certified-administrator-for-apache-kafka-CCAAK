# Confluent Certified Administrator for Apache Kafka (CCAAK) practise exam questions - sample 1

## 1.0 Kafka Fundamentals (15%)

### 1. What is the primary role of a Kafka broker? *(Unique Answer)*
- a) Store messages
- b) Manage consumer groups
- c) Coordinate partition replication
- d) All of the above
<details>
<summary>Solution</summary>
**Correct Answer:** d) All of the above
</details>

### 2. Which of the following are components of Kafka? *(Multiple Answers)*
- a) Producer
- b) Consumer
- c) Zookeeper
- d) Scheduler
<details>
<summary>Solution</summary>
**Correct Answers:** a) Producer, b) Consumer, c) Zookeeper
</details>

### 3. What is the purpose of a Kafka topic? *(Unique Answer)*
- a) To group related messages
- b) To store consumer offsets
- c) To manage producer connections
- d) To define message formats
<details>
<summary>Solution</summary>
**Correct Answer:** a) To group related messages
</details>

### 4. Which factors can affect the performance of Kafka? *(Multiple Answers)*
- a) Number of partitions
- b) Replication factor
- c) Message size
- d) Consumer group size
<details>
<summary>Solution</summary>
**Correct Answers:** a) Number of partitions, b) Replication factor, c) Message size
</details>

### 5. What does the term "offset" refer to in Kafka? *(Unique Answer)*
- a) The position of a message within a topic partition
- b) The time a message was produced
- c) The size of a message
- d) The ID of a producer
<details>
<summary>Solution</summary>
**Correct Answer:** a) The position of a message within a topic partition
</details>

## 2.0 Managing, Configuring, and Optimizing a Cluster for Performance (30%)

### 1. What configuration property is used to set the number of partitions for a topic? *(Unique Answer)*
- a) num.partitions
- b) partitions.count
- c) topic.partitions
- d) partition.size
<details>
<summary>Solution</summary>
**Correct Answer:** a) num.partitions
</details>

### 2. Which of the following configurations can be tuned to improve Kafka performance? *(Multiple Answers)*
- a) linger.ms
- b) buffer.memory
- c) max.poll.records
- d) auto.offset.reset
<details>
<summary>Solution</summary>
**Correct Answers:** a) linger.ms, b) buffer.memory, c) max.poll.records
</details>

### 3. How can you increase the fault tolerance of a Kafka cluster? *(Unique Answer)*
- a) Increase the number of partitions
- b) Increase the replication factor
- c) Use multiple consumers
- d) Decrease message size
<details>
<summary>Solution</summary>
**Correct Answer:** b) Increase the replication factor
</details>

### 4. What monitoring tools can be used to assess the health of a Kafka cluster? *(Multiple Answers)*
- a) JMX
- b) Kafka Manager
- c) Grafana
- d) Prometheus
<details>
<summary>Solution</summary>
**Correct Answers:** a) JMX, b) Kafka Manager, c) Grafana, d) Prometheus
</details>

### 5. What is the significance of the replication.factor setting in Kafka? *(Unique Answer)*
- a) Determines how many copies of a message are retained
- b) Controls message format
- c) Sets the maximum message size
- d) Defines consumer group behavior
<details>
<summary>Solution</summary>
**Correct Answer:** a) Determines how many copies of a message are retained
</details>

### 6. Which metrics are critical for monitoring Kafka broker performance? *(Multiple Answers)*
- a) Under-replicated partitions
- b) Request latency
- c) Bytes produced/consumed
- d) Disk usage
<details>
<summary>Solution</summary>
**Correct Answers:** a) Under-replicated partitions, b) Request latency, c) Bytes produced/consumed
</details>

### 7. What is the purpose of configuring min.insync.replicas? *(Unique Answer)*
- a) To define how many replicas must acknowledge a write
- b) To limit the number of partitions
- c) To specify the maximum consumer lag
- d) To set the retention time for messages
<details>
<summary>Solution</summary>
**Correct Answer:** a) To define how many replicas must acknowledge a write
</details>

### 8. When would you consider increasing the number of partitions for a topic? *(Multiple Answers)*
- a) High consumer lag
- b) Increased throughput requirement
- c) Reducing message size
- d) More producers
<details>
<summary>Solution</summary>
**Correct Answers:** a) High consumer lag, b) Increased throughput requirement, d) More producers
</details>

### 9. What is the role of Zookeeper in a Kafka cluster? *(Unique Answer)*
- a) Manage distributed configurations
- b) Store messages
- c) Handle producer requests
- d) Monitor consumer performance
<details>
<summary>Solution</summary>
**Correct Answer:** a) Manage distributed configurations
</details>

### 10. Which of the following configurations affect message durability? *(Multiple Answers)*
- a) acks
- b) compression.type
- c) enable.idempotence
- d) retention.ms
<details>
<summary>Solution</summary>
**Correct Answers:** a) acks, c) enable.idempotence, d) retention.ms
</details>

### 11. How does Kafka handle message ordering within a partition? *(Unique Answer)*
- a) By maintaining a sequential log
- b) By using timestamps
- c) By assigning unique IDs
- d) By round-robin distribution
<details>
<summary>Solution</summary>
**Correct Answer:** a) By maintaining a sequential log
</details>

### 12. What are the benefits of configuring a Kafka cluster with multiple brokers? *(Multiple Answers)*
- a) Load balancing
- b) High availability
- c) Reduced latency
- d) Better data retention
<details>
<summary>Solution</summary>
**Correct Answers:** b) High availability, a) Load balancing
</details>

### 13. What is the purpose of the log.retention.hours configuration? *(Unique Answer)*
- a) To specify how long logs are retained
- b) To control log file size
- c) To determine how often logs are compressed
- d) To set the number of log segments
<details>
<summary>Solution</summary>
**Correct Answer:** a) To specify how long logs are retained
</details>

## 3.0 Kafka Security (15%)

### 1. What is the primary purpose of enabling SSL in Kafka? *(Unique Answer)*
- a) To encrypt data in transit
- b) To authenticate brokers
- c) To monitor performance
- d) To reduce latency
<details>
<summary>Solution</summary>
**Correct Answer:** a) To encrypt data in transit
</details>

### 2. Which security mechanisms can be implemented in Kafka? *(Multiple Answers)*
- a) Authentication
- b) Authorization
- c) Encryption
- d) Logging
<details>
<summary>Solution</summary>
**Correct Answers:** a) Authentication, b) Authorization, c) Encryption
</details>

### 3. What is the difference between ACLs and authentication in Kafka? *(Unique Answer)*
- a) ACLs control access, while authentication verifies identity
- b) ACLs are for brokers, while authentication is for producers
- c) ACLs are optional, while authentication is mandatory
- d) There is no difference
<details>
<summary>Solution</summary>
**Correct Answer:** a) ACLs control access, while authentication verifies identity
</details>

### 4. What types of authentication can Kafka support? *(Multiple Answers)*
- a) SASL/PLAIN
- b) Kerberos
- c) OAuth
- d) SSL Certificates
<details>
<summary>Solution</summary>
**Correct Answers:** a) SASL/PLAIN, b) Kerberos, c) OAuth, d) SSL Certificates
</details>

### 5. How can you restrict which users can produce or consume from a Kafka topic? *(Unique Answer)*
- a) By using Access Control Lists (ACLs)
- b) By configuring the replication factor
- c) By setting retention policies
- d) By changing the topic name
<details>
<summary>Solution</summary>
**Correct Answer:** a) By using Access Control Lists (ACLs)
</details>

## 4.0 Designing, Troubleshooting, and Integrating Systems (40%)

### 1. What is the recommended approach for designing a Kafka topic structure? *(Unique Answer)*
- a) Create one topic for all messages
- b) Separate topics by data type or use case
- c) Use the default settings
- d) Create topics based on partition count
<details>
<summary>Solution</summary>
**Correct Answer:** b) Separate topics by data type or use case
</details>

### 2. Which factors should be considered when designing a Kafka-based architecture? *(Multiple Answers)*
- a) Data volume
- b) Consumer processing speed
- c) Message format
- d) Network latency
<details>
<summary>Solution</summary>
**Correct Answers:** a) Data volume, b) Consumer processing speed, d) Network latency
</details>

### 3. How can you troubleshoot a consumer lag issue in Kafka? *(Unique Answer)*
- a) Increase the number of partitions
- b) Check consumer configurations and performance
- c) Restart the broker
- d) Change the replication factor
<details>
<summary>Solution</summary>
**Correct Answer:** b) Check consumer configurations and performance
</details>

### 4. What are common causes of message delivery failures in Kafka? *(Multiple Answers)*
- a) Broker downtime
- b) Network issues
- c) Incorrect consumer group
- d) Schema incompatibility
<details>
<summary>Solution</summary>
**Correct Answers:** a) Broker downtime, b) Network issues, c) Incorrect consumer group
</details>

### 5. What is the significance of commit.interval.ms in consumer configurations? *(Unique Answer)*
- a) It determines how often offsets are committed
- b) It sets the maximum message size
- c) It controls consumer group behavior
- d) It defines the retention time for messages
<details>
<summary>Solution</summary>
**Correct Answer:** a) It determines how often offsets are committed
</details>

### 6. Which integration patterns are commonly used with Kafka? *(Multiple Answers)*
- a) Event sourcing
- b) CQRS
- c) Microservices communication
- d) Batch processing
<details>
<summary>Solution</summary>
**Correct Answers:** a) Event sourcing, b) CQRS
</details>

### 7. What is the role of the Schema Registry in a Kafka ecosystem? *(Unique Answer)*
- a) To manage message schemas for compatibility
- b) To store consumer offsets
- c) To configure broker settings
- d) To handle authentication
<details>
<summary>Solution</summary>
**Correct Answer:** a) To manage message schemas for compatibility
</details>

### 8. What are the best practices for error handling in Kafka consumers? *(Multiple Answers)*
- a) Use dead-letter queues
- b) Implement retries
- c) Ignore errors
- d) Log errors
<details>
<summary>Solution</summary>
**Correct Answers:** a) Use dead-letter queues, b) Implement retries, d) Log errors
</details>

### 9. What is the purpose of using Kafka Connect? *(Unique Answer)*
- a) To integrate Kafka with other systems
- b) To manage consumer groups
- c) To configure brokers
- d) To monitor cluster health
<details>
<summary>Solution</summary>
**Correct Answer:** a) To integrate Kafka with other systems
</details>

### 10. Which of the following are considerations when setting up Kafka Connect? *(Multiple Answers)*
- a) Connector type
- b) Task parallelism
- c) Data transformation
- d) Source and sink configurations
<details>
<summary>Solution</summary>
**Correct Answers:** a) Connector type, b) Task parallelism, d) Source and sink configurations
</details>

### 11. How can you monitor the performance of Kafka consumers? *(Unique Answer)*
- a) By tracking consumer lag metrics
- b) By checking broker logs
- c) By analyzing producer metrics
- d) By configuring retention policies
<details>
<summary>Solution</summary>
**Correct Answer:** a) By tracking consumer lag metrics
</details>

### 12. What strategies can be used to ensure message order in Kafka consumers? *(Multiple Answers)*
- a) Single partition consumption
- b) Keyed messages
- c) Parallel processing
- d) Consumer groups
<details>
<summary>Solution</summary>
**Correct Answers:** a) Single partition consumption, b) Keyed messages
</details>

### 13. What is the role of the enable.auto.commit configuration for consumers? *(Unique Answer)*
- a) To automatically commit offsets
- b) To control message delivery
- c) To set retention policies
- d) To define partitions
<details>
<summary>Solution</summary>
**Correct Answer:** a) To automatically commit offsets
</details>

### 14. Which techniques can be used to optimize Kafka producer performance? *(Multiple Answers)*
- a) Batch sending
- b) Compression
- c) Asynchronous sending
- d) Single message sends
<details>
<summary>Solution</summary>
**Correct Answers:** a) Batch sending, b) Compression, c) Asynchronous sending
</details>

### 15. What is the impact of increasing the linger.ms configuration? *(Unique Answer)*
- a) Increases latency for batching
- b) Reduces throughput
- c) Ensures message ordering
- d) Decreases memory usage
<details>
<summary>Solution</summary>
**Correct Answer:** a) Increases latency for batching
</details>

### 16. Which types of data formats are typically used with Kafka? *(Multiple Answers)*
- a) JSON
- b) Avro
- c) XML
- d) Parquet
<details>
<summary>Solution</summary>
**Correct Answers:** a) JSON, b) Avro, c) XML
</details>

### 17. What is the difference between a consumer and a consumer group in Kafka? *(Unique Answer)*
- a) A consumer is a single instance, while a consumer group is a set of consumers
- b) They are the same
- c) A consumer receives messages, while a consumer group produces messages
- d) A consumer is for topics, while a consumer group is for partitions
<details>
<summary>Solution</summary>
**Correct Answer:** a) A consumer is a single instance, while a consumer group is a set of consumers
</details>

### 18. What considerations should be made when migrating data into Kafka from other systems? *(Multiple Answers)*
- a) Data mapping
- b) Throughput requirements
- c) Data validation
- d) Schema evolution
<details>
<summary>Solution</summary>
**Correct Answers:** a) Data mapping, b) Throughput requirements, c) Data validation, d) Schema evolution
</details>

### 19. How can you handle schema evolution in Kafka? *(Unique Answer)*
- a) By using a Schema Registry
- b) By deleting old topics
- c) By keeping all data in JSON format
- d) By increasing the number of partitions
<details>
<summary>Solution</summary>
**Correct Answer:** a) By using a Schema Registry
</details>

### 20. What are the common use cases for Kafka in real-time data streaming? *(Multiple Answers)*
- a) Log aggregation
- b) Data integration
- c) Real-time analytics
- d) Batch processing
<details>
<summary>Solution</summary>
**Correct Answers:** a) Log aggregation, b) Data integration, c) Real-time analytics
</details>

### 21. What is the significance of the acks configuration in a producer? *(Unique Answer)*
- a) It determines how many acknowledgments are required for a successful write
- b) It controls message compression
- c) It defines message retention time
- d) It sets the maximum message size
<details>
<summary>Solution</summary>
**Correct Answer:** a) It determines how many acknowledgments are required for a successful write
</details>

## 5.0 Miscellaneous (Optional)

### 1. How does Kafka handle data replication? *(Unique Answer)*
- a) By storing copies of messages across multiple brokers
- b) By compressing data
- c) By using Zookeeper only
- d) By deleting old messages
<details>
<summary>Solution</summary>
**Correct Answer:** a) By storing copies of messages across multiple brokers
</details>

### 2. What are the advantages of using Kafka over traditional messaging systems? *(Multiple Answers)*
- a) Scalability
- b) Durability
- c) Low latency
- d) Complexity
<details>
<summary>Solution</summary>
**Correct Answers:** a) Scalability, b) Durability, c) Low latency
</details>

### 3. What does "exactly-once" delivery mean in Kafka? *(Unique Answer)*
- a) Messages are processed once and only once
- b) Messages can be lost
- c) Messages may be duplicated
- d) Messages are stored indefinitely
<details>
<summary>Solution</summary>
**Correct Answer:** a) Messages are processed once and only once
</details>

### 4. Which scenarios would benefit from using Kafka Streams? *(Multiple Answers)*
- a) Stateful processing
- b) Batch processing
- c) Real-time analytics
- d) Data enrichment
<details>
<summary>Solution</summary>
**Correct Answers:** a) Stateful processing, c) Real-time analytics, d) Data enrichment
</details>

### 5. How can you achieve fault tolerance in a Kafka consumer application? *(Unique Answer)*
- a) By using multiple consumer instances and groups
- b) By reducing the number of partitions
- c) By disabling auto-commit
- d) By increasing the retention time
<details>
<summary>Solution</summary>
**Correct Answer:** a) By using multiple consumer instances and groups
</details>

### 6. What are the consequences of setting the retention policy too low? *(Unique Answer)*
- a) Data loss
- b) Increased performance
- c) Reduced storage costs
- d) Compacted topics
<details>
<summary>Solution</summary>
**Correct Answer:** a) Data loss
</details>

### 7. What are the implications of setting delete.retention.ms too low? *(Unique Answer)*
- a) Messages may be deleted before consumers can read them
- b) Increased storage usage
- c) Messages will be retained longer
- d) No impact
<details>
<summary>Solution</summary>
**Correct Answer:** a) Messages may be deleted before consumers can read them
</details>

### 8. Which tools can be used for testing Kafka applications? *(Multiple Answers)*
- a) Kafka Test
- b) JUnit
- c) LoadRunner
- d) Apache JMeter
<details>
<summary>Solution</summary>
**Correct Answers:** b) JUnit, c) LoadRunner, d) Apache JMeter
</details>

### 9. What is the purpose of the log.segment.bytes configuration? *(Unique Answer)*
- a) To define the size of log segments
- b) To set the retention period
- c) To control the number of partitions
- d) To manage consumer offsets
<details>
<summary>Solution</summary>
**Correct Answer:** a) To define the size of log segments
</details>

### 10. Which factors should be monitored to maintain Kafka performance? *(Multiple Answers)*
- a) CPU usage
- b) Memory usage
- c) Disk I/O
- d) Network bandwidth
<details>
<summary>Solution</summary>
**Correct Answers:** a) CPU usage, b) Memory usage, c) Disk I/O, d) Network bandwidth
</details>

### 11. What is the impact of running multiple consumer instances in a consumer group? *(Unique Answer)*
- a) Increased message processing throughput
- b) Messages will be duplicated
- c) Consumer lag will be higher
- d) Messages will be lost
<details>
<summary>Solution</summary>
**Correct Answer:** a) Increased message processing throughput
</details>