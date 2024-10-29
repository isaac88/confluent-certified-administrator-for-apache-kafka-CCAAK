# Confluent Certified Administrator for Apache Kafka (CCAAK) practise exam questions - sample 4

## Questions

### 1.0 Kafka Fundamentals (15%)

#### 1.1 What is Kafka primarily used for? (Choose One)
   a. Data visualization  
   b. Data storage  
   c. Message brokering and stream processing  
   d. Batch processing  
   <details><summary>Answer</summary>c - Kafka is primarily used as a distributed message broker for real-time stream processing and handling of data.</details>

#### 1.2 What is a Kafka Broker? (Choose One)
   a. A tool for managing consumer groups  
   b. A server that stores and serves messages to producers and consumers  
   c. A client application that produces messages  
   d. A configuration management system  
   <details><summary>Answer</summary>b - A Kafka broker is a server that stores messages in topics and serves client requests from producers and consumers.</details>

#### 1.3 What is the role of the `high-water mark` in Kafka? (Choose One)
   a. It indicates the last message acknowledged by a producer  
   b. It shows the highest offset for messages that have been successfully replicated  
   c. It defines the retention period for messages  
   d. It marks the beginning of a new log segment  
   <details><summary>Answer</summary>b - The high-water mark indicates the highest offset of messages that have been fully replicated and acknowledged by all in-sync replicas.</details>

#### 1.4 What does a Kafka topic represent? (Choose One)
   a. A single message stream  
   b. A collection of messages  
   c. A data processing unit  
   d. A configuration setting  
   <details><summary>Answer</summary>b - A Kafka topic is a category or feed name to which records are published, representing a collection of messages.</details>

#### 1.5 What is the purpose of partitioning in Kafka? (Choose One)
   a. To enhance security  
   b. To allow multiple consumers to read from a topic simultaneously  
   c. To ensure data is stored indefinitely  
   d. To manage backup processes  
   <details><summary>Answer</summary>b - Partitioning allows Kafka to scale horizontally by enabling multiple consumers to read from a topic in parallel, enhancing throughput and performance.</details>

### 2.0 Managing, Configuring, and Optimizing a Cluster for Performance (30%)

#### 2.1 How can you optimize producer performance in Kafka? (Choose Two)
   a. Increase batch size  
   b. Reduce the number of partitions  
   c. Enable compression  
   d. Use synchronous sends  
   <details><summary>Answer</summary>a, c - Increasing batch size and enabling compression can both lead to significant improvements in producer performance by reducing overhead and increasing throughput.</details>

#### 2.2 Which metric would be most useful for monitoring broker performance? (Choose One)
   a. Consumer lag  
   b. Disk I/O  
   c. Message size  
   d. Number of topics  
   <details><summary>Answer</summary>b - Disk I/O is crucial for monitoring broker performance as it affects the speed at which brokers can read and write messages.</details>

#### 2.3 What configuration property controls the maximum size of a message in Kafka? (Choose One)
   a. message.max.bytes  
   b. log.retention.bytes  
   c. max.partition.fetch.bytes  
   d. max.request.size  
   <details><summary>Answer</summary>a - The `message.max.bytes` property defines the maximum size of a message that can be sent to a Kafka topic.</details>

#### 2.4 What does the `replication.factor` setting determine for a Kafka topic? (Choose One)
   a. The number of partitions per broker  
   b. The number of replicas for each partition  
   c. The maximum size of messages  
   d. The retention period for messages  
   <details><summary>Answer</summary>b - The `replication.factor` setting specifies the number of replicas for each partition, enhancing data availability and fault tolerance.</details>

#### 2.5 How can you improve consumer performance in a Kafka cluster? (Choose Two)
   a. Adjust `max.poll.records` to a higher value  
   b. Increase the number of partitions  
   c. Use fewer consumer groups  
   d. Enable auto-commit of offsets  
   <details><summary>Answer</summary>a, b - Adjusting `max.poll.records` allows consumers to process more messages at once, and increasing the number of partitions can enhance parallelism and performance.</details>

#### 2.6 What is the purpose of the `log.retention.ms` setting in Kafka? (Choose One)
   a. To define how long messages are stored in a topic  
   b. To configure log compaction settings  
   c. To control the size of log segments  
   d. To manage the number of replicas  
   <details><summary>Answer</summary>a - The `log.retention.ms` setting specifies the duration for which messages are retained in a topic before being eligible for deletion.</details>

#### 2.7 Which tool can be used to monitor Kafka broker metrics? (Choose One)
   a. Zookeeper  
   b. JMX (Java Management Extensions)  
   c. Kafka Console Producer  
   d. Kafka Connect  
   <details><summary>Answer</summary>b - JMX is used to monitor Kafka broker metrics, allowing you to track performance and operational health.</details>

#### 2.8 How can you ensure that a Kafka topic is properly configured for optimal throughput? (Choose One)
   a. By using the default settings for all properties  
   b. By balancing the number of partitions and replication factor  
   c. By disabling compression  
   d. By limiting the number of consumers  
   <details><summary>Answer</summary>b - Properly balancing the number of partitions and the replication factor can lead to improved throughput and resource utilization.</details>

#### 2.9 What happens when a Kafka broker is configured with a low `num.partitions` setting? (Choose One)
   a. It increases replication  
   b. It limits parallelism in message consumption  
   c. It enhances message delivery speed  
   d. It automatically deletes topics  
   <details><summary>Answer</summary>b - A low `num.partitions` setting limits the number of consumers that can read from a topic in parallel, potentially reducing throughput.</details>

#### 2.10 Which of the following configurations can help reduce consumer lag? (Choose Two)
   a. Increasing `session.timeout.ms`  
   b. Using a higher `fetch.max.bytes`  
   c. Reducing the number of partitions  
   d. Increasing the number of consumers in a group  
   <details><summary>Answer</summary>b, d - Increasing `fetch.max.bytes` allows consumers to receive more data in one fetch request, and adding more consumers helps balance the load, reducing lag.</details>

#### 2.11 How are memory resources managed in a Kafka broker? (Choose One)
   a. Through Zookeeper configurations  
   b. By JVM heap size settings  
   c. By consumer group settings  
   d. By partition configuration  
   <details><summary>Answer</summary>b - Memory resources in a Kafka broker are managed through the JVM heap size settings, which define the amount of memory available for processing.</details>

#### 2.12 What is the effect of having too many partitions in a Kafka topic? (Choose One)
   a. Decreased data availability  
   b. Increased overhead for managing partitions  
   c. Improved data compression  
   d. Simplified consumer management  
   <details><summary>Answer</summary>b - Having too many partitions can increase management overhead, as each partition requires resources for tracking and coordination.</details>

#### 2.13 What is the recommended action if a Kafka consumer experiences high latency? (Choose One)
   a. Increase the number of partitions  
   b. Decrease the consumer group size  
   c. Optimize the fetch size and poll intervals  
   d. Reduce the replication factor  
   <details><summary>Answer</summary>c - Optimizing the fetch size and poll intervals can help reduce latency by ensuring that consumers are efficiently retrieving data.</details>

#### 2.14 What effect does configuring a low `linger.ms` have on producer performance? (Choose One)
   a. It increases batch sizes  
   b. It can decrease throughput  
   c. It decreases latency  
   d. It leads to frequent retries  
   <details><summary>Answer</summary>c - A low `linger.ms` setting allows messages to be sent more quickly, thereby reducing latency, as the producer does not wait for additional messages.</details>

#### 2.15 What configuration property controls how many messages a consumer can fetch in one request? (Choose One)
   a. fetch.max.bytes  
   b. max.poll.records  
   c. max.partition.fetch.bytes  
   d. consumer.timeout.ms  
   <details><summary>Answer</summary>b - The `max.poll.records` configuration specifies the maximum number of records the consumer can retrieve in a single call to poll.</details>

### 3.0 Kafka Security (15%)

#### 3.1 How can you implement authentication in Kafka? (Choose One)
   a. Through ACLs only  
   b. By using SSL or SASL mechanisms  
   c. By configuring retention policies  
   d. By monitoring access logs  
   <details><summary>Answer</summary>b - Authentication in Kafka can be implemented using SSL (Secure Sockets Layer) or SASL (Simple Authentication and Security Layer) to secure connections.</details>

#### 3.2 What is the purpose of Access Control Lists (ACLs) in Kafka? (Choose One)
   a. To define the retention period for topics  
   b. To manage the number of partitions  
   c. To specify which users or applications can access resources  
   d. To control compression types  
   <details><summary>Answer</summary>c - ACLs are used to define permissions for users or applications, specifying which can read, write, or manage specific topics or consumer groups.</details>

#### 3.3 Which of the following configurations can enhance data encryption in Kafka? (Choose Two)
   a. Enable SSL on brokers  
   b. Use plaintext for message storage  
   c. Configure TLS for client connections  
   d. Disable authentication  
   <details><summary>Answer</summary>a, c - Enabling SSL on brokers and configuring TLS for client connections help ensure that data is encrypted during transmission, enhancing security.</details>

#### 3.4 What does the `sasl.enabled.mechanisms` configuration control? (Choose One)
   a. The types of compression used  
   b. The authentication methods for clients  
   c. The retention policy for messages  
   d. The logging level for brokers  
   <details><summary>Answer</summary>b - The `sasl.enabled.mechanisms` setting specifies which SASL authentication mechanisms are enabled for client connections to the Kafka cluster.</details>

#### 3.5 How can you secure a Kafka cluster against unauthorized access? (Choose Two)
   a. Implement SSL/TLS for data encryption  
   b. Use strong password policies for user accounts  
   c. Disable all consumer groups  
   d. Configure ACLs for topics and resources  
   <details><summary>Answer</summary>a, d - Implementing SSL/TLS encrypts data in transit, while configuring ACLs helps control access to topics and resources based on user permissions.</details>

### 4.0 Designing, Troubleshooting, and Integrating Systems (40%)

#### 4.1 What is the primary consideration when designing a Kafka topic architecture? (Choose One)
   a. Ease of use  
   b. Data retention needs and access patterns  
   c. Number of producers  
   d. Client application capabilities  
   <details><summary>Answer</summary>b - When designing a Kafka topic architecture, it is essential to consider data retention needs and access patterns to optimize performance and resource usage.</details>

#### 4.2 What should be done when Kafka consumers are experiencing high lag? (Choose Two)
   a. Increase the number of partitions  
   b. Reduce the retention period  
   c. Optimize consumer processing logic  
   d. Decrease the replication factor  
   <details><summary>Answer</summary>a, c - Increasing the number of partitions allows more parallel consumption, and optimizing consumer logic can improve processing efficiency and reduce lag.</details>

#### 4.3 How can you troubleshoot a Kafka consumer that is not receiving messages? (Choose Two)
   a. Check if the topic exists and has messages  
   b. Verify the consumer group ID is correct  
   c. Reduce the number of partitions  
   d. Disable message compression  
   <details><summary>Answer</summary>a, b - Ensuring that the topic exists with messages and verifying that the consumer group ID is correctly configured are critical troubleshooting steps for consumers.</details>

#### 4.4 What is a common method for integrating Kafka with external systems? (Choose One)
   a. Using Kafka Streams  
   b. Writing custom producer applications  
   c. Utilizing Kafka Connect with source/sink connectors  
   d. Directly modifying data in Zookeeper  
   <details><summary>Answer</summary>c - Kafka Connect provides a straightforward way to integrate Kafka with various external systems using pre-built source and sink connectors.</details>

#### 4.5 How can you ensure fault tolerance when designing a Kafka cluster? (Choose Two)
   a. Use a high replication factor for topics  
   b. Limit the number of brokers  
   c. Deploy brokers across multiple data centers  
   d. Use single-node clusters  
   <details><summary>Answer</summary>a, c - Using a high replication factor and deploying brokers across multiple data centers enhances fault tolerance and protects against data loss during outages.</details>

#### 4.6 What is the primary challenge when integrating Kafka with a relational database? (Choose One)
   a. Schema mismatch  
   b. Increased latency  
   c. Data volume  
   d. No support for ACID transactions  
   <details><summary>Answer</summary>d - Kafka does not inherently support ACID transactions, which can complicate integrations with relational databases that require strict transaction management.</details>

#### 4.7 What is a recommended strategy for handling schema evolution in Kafka? (Choose One)
   a. Use a fixed schema for all messages  
   b. Use a versioned schema approach with Schema Registry  
   c. Alter messages in place  
   d. Delete and recreate topics  
   <details><summary>Answer</summary>b - Employing a versioned schema approach with Schema Registry helps manage and evolve message schemas without breaking existing consumers.</details>

#### 4.8 Which monitoring tool is commonly used to observe Kafka health and performance? (Choose One)
   a. Prometheus  
   b. JIRA  
   c. Grafana  
   d. Kibana  
   <details><summary>Answer</summary>a - Prometheus is commonly used to monitor Kafka clusters, collecting metrics that can be visualized for performance analysis.</details>

#### 4.9 When designing a Kafka topic for high availability, what factor should you consider? (Choose One)
   a. The number of producers  
   b. The number of consumers  
   c. The replication factor and partition count  
   d. The message size  
   <details><summary>Answer</summary>c - The replication factor and partition count are critical for ensuring high availability, as they determine how data is duplicated across brokers.</details>

#### 4.10 What is the best practice for processing large data streams in Kafka? (Choose Two)
   a. Use smaller batch sizes to reduce latency  
   b. Implement Kafka Streams for real-time processing  
   c. Aggregate data before sending to Kafka  
   d. Increase the number of partitions for the topic  
   <details><summary>Answer</summary>b, d - Implementing Kafka Streams enables real-time processing, and increasing partitions allows for parallelism, enhancing performance for large data streams.</details>

#### 4.11 What can be used to validate message formats before they are sent to Kafka? (Choose One)
   a. Access Control Lists  
   b. Schema Registry  
   c. Message Compression  
   d. Consumer Groups  
   <details><summary>Answer</summary>b - Schema Registry can be used to validate message formats against defined schemas before messages are sent to Kafka.</details>

#### 4.12 In case of a broker failure, what happens to the messages being produced? (Choose One)
   a. They are lost permanently  
   b. They are queued until the broker is back online  
   c. They are redirected to a different broker if replication is set  
   d. They are stored in memory until the broker recovers  
   <details><summary>Answer</summary>c - If replication is enabled, messages will be redirected to another broker holding a replica of the partition, ensuring they are not lost.</details>

#### 4.13 How can you effectively manage consumer group offsets? (Choose One)
   a. By using automatic offset commits only  
   b. By manually committing offsets based on processing  
   c. By deleting consumer group records  
   d. By reconfiguring the consumer group  
   <details><summary>Answer</summary>b - Managing consumer group offsets through manual commits based on successful processing is an effective way to ensure accurate tracking of message consumption.</details>

#### 4.14 What is a potential issue when using multiple consumer groups on the same topic? (Choose One)
   a. Increased throughput  
   b. Message duplication  
   c. Higher latency  
   d. Resource contention  
   <details><summary>Answer</summary>d - Multiple consumer groups can lead to resource contention as they compete for the same topic's partitions, potentially affecting overall performance.</details>

#### 4.15 How can you design a system to handle backpressure in Kafka? (Choose One)
   a. By increasing the number of partitions  
   b. By throttling producers when necessary  
   c. By reducing consumer throughput  
   d. By extending the retention period  
   <details><summary>Answer</summary>b - Implementing throttling for producers during high load can help manage backpressure and prevent overwhelming the system.</details>