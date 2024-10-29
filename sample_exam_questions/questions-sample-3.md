# Confluent Certified Administrator for Apache Kafka (CCAAK) practise exam questions - sample 3

## Questions

### 1. Which of the following are valid ways to increase scalability in a Kafka cluster? (Choose Two)
   a. Adding more brokers  
   b. Increasing replication factor  
   c. Adding more partitions to topics  
   d. Decreasing retention time  
   <details><summary>Answer</summary>a, c - Adding more brokers enhances capacity as well as reliability, while increasing the number of partitions allows more consumers to read messages in parallel.</details>

### 2. What is the primary role of a Kafka Connector? (Choose One)
   a. To process data before it is sent to Kafka  
   b. To move data between Kafka and external systems  
   c. To manage consumer offsets  
   d. To configure broker settings  
   <details><summary>Answer</summary>b - Kafka Connectors serve to facilitate the movement of data between Kafka and other systems, such as databases or key-value stores.</details>

### 3. How is schema evolution handled in Kafka? (Choose One)
   a. By deleting old schemas  
   b. By using a Schema Registry  
   c. By updating the topic configuration  
   d. By using consumer group IDs  
   <details><summary>Answer</summary>b - Schema evolution is managed by a Schema Registry, which allows for multiple versions of a schema to exist and helps maintain compatibility.</details>

### 4. What does the “acks” parameter in the producer configuration control? (Choose One)
   a. The maximum number of messages the producer can send  
   b. The level of acknowledgment required from the server  
   c. The duration messages are retained  
   d. The number of retries allowed for failed messages  
   <details><summary>Answer</summary>b - The "acks" parameter sets the acknowledgment level from the broker to the producer, affecting durability and data loss risk.</details>

### 5. Which of the following can lead to an increase in message latency in Kafka? (Choose Two)
   a. High network congestion  
   b. Low batch sizes  
   c. Configuring fast producers  
   d. High retention period  
   <details><summary>Answer</summary>a, b - High network congestion can delay message transmission, while low batch sizes increase the number of requests and round-trip times.</details>

### 6. In Kafka, what is the purpose of a "Topic Partition"? (Choose One)
   a. To categorize producers  
   b. To segment message storage for scalability and parallelism  
   c. To manage consumer offsets  
   d. To hold replication data  
   <details><summary>Answer</summary>b - Topic partitions allow Kafka to distribute data across multiple brokers and enable parallel consumption, improving scalability.</details>

### 7. Which of the following attributes can improve data integrity in Kafka? (Choose Two)
   a. Message compression  
   b. Idempotent producer settings  
   c. Retention period configuration  
   d. Confluent Cloud integration  
   <details><summary>Answer</summary>b, c - Using idempotent producers helps prevent duplicate messages, while proper retention settings ensure that messages are retained as long as needed without loss.</details>

### 8. What happens to messages in a Kafka topic once the log retention period expires? (Choose One)
   a. They are archived to an external storage  
   b. They are deleted  
   c. They are compacted  
   d. They stay indefinitely  
   <details><summary>Answer</summary>b - Once the log retention period expires, messages are eligible for deletion according to the topic’s retention policy.</details>

### 9. In a Kafka cluster, what is the purpose of the `log.cleanup.policy` configuration? (Choose One)
   a. To control how long logs are retained  
   b. To determine how logs are compacted or deleted  
   c. To enable automatic partitioning  
   d. To configure the replication strategy  
   <details><summary>Answer</summary>b - The `log.cleanup.policy` configuration determines if log entries are deleted or compacted based on retention policies.</details>

### 10. What is the role of the `compression.type` configuration in Kafka? (Choose One)
   a. To specify how messages are compressed  
   b. To enable or disable replication  
   c. To define the message format  
   d. To limit log segment size  
   <details><summary>Answer</summary>a - The `compression.type` configuration determines how data is compressed before being stored, which can save space and improve throughput.</details>

### 11. Which of the following can be used for stream processing with Kafka? (Choose Two)
   a. KSQL  
   b. Kafka Connect  
   c. Apache Flink  
   d. Apache Spark   
   <details><summary>Answer</summary>a, c - KSQL is a streaming SQL engine for Kafka, while Apache Flink provides powerful stream processing capabilities that can be integrated with Kafka.</details>

### 12. What affects the maximum message size that can be sent in Kafka? (Choose One)
   a. Topic retention policy  
   b. Broker configuration  
   c. Zookeeper settings  
   d. Consumer lag  
   <details><summary>Answer</summary>b - The maximum message size is determined by the `max.message.bytes` setting in the broker configuration.</details>

### 13. When would a producer receive an "UnknownTopicOrPartition" error? (Choose One)
   a. When trying to send a message to a non-existent topic  
   b. When a partition becomes unavailable  
   c. When the producer is misconfigured  
   d. When a broker restarts  
   <details><summary>Answer</summary>a - An "UnknownTopicOrPartition" error occurs when a producer tries to send a message to a topic that does not exist or has not been created.</details>

### 14. Which component is responsible for producing messages to Kafka topics? (Choose One)
   a. Kafka Broker  
   b. Kafka Consumer  
   c. Kafka Producer  
   d. Zookeeper  
   <details><summary>Answer</summary>c - The Kafka Producer is the component responsible for sending messages to specified Kafka topics.</details>

### 15. What does the configuration property `delete.retention.ms` control? (Choose One)
   a. Duration for which messages are kept after deletion  
   b. Maximum time for consumer acknowledgment  
   c. How long messages are retained before deletion  
   d. Time for which a topic can exist  
   <details><summary>Answer</summary>a - The `delete.retention.ms` setting specifies how long to retain deleted messages before they are permanently removed from the log.</details>

### 16. Which of the following strategies can be used to ensure message processing correctness? (Choose Two)
   a. Exactly-once semantics  
   b. Idempotent producers  
   c. Consumer group auto scaling  
   d. Increasing retention period  
   <details><summary>Answer</summary>a, b - Exactly-once semantics and using idempotent producers help ensure that messages are processed exactly one time, mitigating issues related to duplicates.</details>

### 17. What does the `max.poll.records` consumer configuration limit? (Choose One)
   a. The maximum number of records returned from a poll operation  
   b. The number of consumers in a group  
   c. The retention period of a topic  
   d. The maximum message size  
   <details><summary>Answer</summary>a - The `max.poll.records` configuration sets a limit on how many records a consumer can retrieve in a single poll request.</details>

### 18. In Kafka, what is a "Log Segment"? (Choose One)
   a. A division of a topic partition where messages are stored  
   b. A temporary storage for uncommitted messages  
   c. The metadata for a Kafka topic  
   d. A mechanism for balancing load  
   <details><summary>Answer</summary>a - A log segment is a file on disk for each partition that holds a sequence of appended messages, facilitating efficient message storage and retrieval.</details>

### 19. How can Kafka guarantee message durability? (Choose One)
   a. By producing messages to the first available partition  
   b. By using replication and acknowledgments  
   c. By partitioning messages across different topics  
   d. By reducing the retention period  
   <details><summary>Answer</summary>b - Replication of messages across multiple brokers, combined with producer acknowledgments, ensures that messages are durable and can survive broker failures.</details>

### 20. Which of the following actions can lead to decreased throughput in a Kafka cluster? (Choose Two)
   a. Low batch size settings  
   b. High replication factor  
   c. Frequent metadata updates due to broker changes  
   d. Increasing the number of partitions  
   <details><summary>Answer</summary>a, c - Low batch sizes increase the overhead of many small requests, while frequent metadata updates can cause performance degradation due to increased coordination overhead.</details>

### 21. What is the role of Kafka's `fetch.min.bytes` configuration? (Choose One)
   a. To limit the size of data written to log  
   b. To configure how much data the server should send to the consumer  
   c. To define message size limits for producers  
   d. To manage the size of buffers in brokers  
   <details><summary>Answer</summary>b - The `fetch.min.bytes` configuration sets the minimum amount of data the server should return for a fetch request, potentially improving throughput.</details>

### 22. Which consumer configuration property can be adjusted to reduce overall latency in message processing? (Choose One)
   a. fetch.min.bytes  
   b. fetch.max.wait.ms  
   c. auto.offset.reset  
   d. max.poll.interval.ms  
   <details><summary>Answer</summary>b - `fetch.max.wait.ms` can be decreased to reduce latency, as it controls how long the client will wait for new data before returning.</details>

### 23. Which of the following can indicate a problem in a consumer group? (Choose Two)
   a. High consumer lag  
   b. Low message throughput  
   c. Too many idle consumers  
   d. A balanced partition distribution  
   <details><summary>Answer</summary>a, c - Increased consumer lag can indicate performance or processing issues, while too many idle consumers may suggest that consumers are unable to handle the load effectively.</details>

### 24. How does Kafka ensure that messages are preserved across restarts? (Choose One)
   a. Using ephemeral nodes in Zookeeper  
   b. Through disk-based storage responsibilities of brokers  
   c. By keeping messages only in memory  
   d. By performing database snapshots  
   <details><summary>Answer</summary>b - Kafka relies on disk-based log storage managed by brokers to ensure that messages are durable and can survive broker restarts.</details>

### 25. What is the significance of the `min.insync.replicas` setting in a Kafka topic? (Choose One)
   a. It dictates how many consumers are needed  
   b. It defines the minimum number of replicas that need to acknowledge a write for it to be considered successful  
   c. It sets the minimum number of partitions  
   d. It controls the minimum retention period  
   <details><summary>Answer</summary>b - The `min.insync.replicas` setting determines the minimum number of in-sync replicas required to acknowledge a write, affecting durability and availability during failures.</details>

### 26. Which command can obtain consumer group details? (Choose One)
   a. kafka-consumer-groups --describe  
   b. list-consumer-groups  
   c. show-consumer-groups  
   d. consumer-groups --list  
   <details><summary>Answer</summary>a - The command "kafka-consumer-groups --describe" is used to retrieve details about consumer groups, including their state and lag.</details>

### 27. In Kafka, what could potentially cause "OutOfMemory" errors in a producer? (Choose Two)
   a. Sending large messages  
   b. Using too many parallel threads  
   c. Misconfigured retention policies  
   d. High message consumption rates  
   <details><summary>Answer</summary>a, b - Sending excessively large messages and utilizing numerous threads without adequate memory can overwhelm the JVM, leading to out-of-memory errors.</details>

### 28. Which of the following configurations can affect read performance in a Kafka consumer? (Choose Two)
   a. fetch.max.bytes  
   b. max.poll.records  
   c. fetch.min.bytes  
   d. consumer group file access  
   <details><summary>Answer</summary>a, b - Configuring `fetch.max.bytes` affects the number of bytes returned in a single fetch request, while `max.poll.records` can limit how many messages are retrieved in one call, impacting throughput.</details>

### 29. What is the function of an "offset" in Kafka? (Choose One)
   a. It represents a timestamp for the message  
   b. It is the unique identifier for messages produced  
   c. It signifies the position of a message within a partition  
   d. It indicates the data size of a message  
   <details><summary>Answer</summary>c - An offset uniquely identifies the position of a message within a particular partition's log, enabling consumers to track message reading.</details>

### 30. What are the advantages of using Kafka with multiple partitions? (Choose Two)
   a. Improved throughput through parallelism  
   b. Loss of message order  
   c. Better fault tolerance  
   d. Increased complexity in consumer management  
   <details><summary>Answer</summary>a, c - Multiple partitions allow for better data distribution for processing (improved throughput), as well as enhancing fault tolerance since replicas can be spread across partitions.</details>

### 31. What is created in Kafka when a message is produced? (Choose One)
   a. An offset  
   b. A consumer  
   c. A log  
   d. A topic  
   <details><summary>Answer</summary>c - Each time a message is produced, it gets appended to the partition's log, providing a sequential record of all messages produced.</details>

### 32. When identifying errors in a consumer's message processing, which configurations might you observe? (Choose Two)
   a. max.poll.interval.ms  
   b. auto.offset.reset  
   c. linger.ms  
   d. session.timeout.ms  
   <details><summary>Answer</summary>a, d - `max.poll.interval.ms` and `session.timeout.ms` are crucial in determining consumer behavior and monitoring potential misconfigurations that could lead to errors or delays in message processing.</details>

### 33. How would you modify a Kafka topic schema without disrupting existing messages? (Choose One)
   a. Drop the topic and recreate it  
   b. Use Schema Registry to evolve the schema  
   c. Edit the topic configuration directly  
   d. Stop all producers  
   <details><summary>Answer</summary>b - Utilizing the Schema Registry allows for schema evolution in a way that maintains compatibility with existing messages while ensuring new messages adhere to the improved schema.</details>

### 34. What happens under the hood when a consumer starts and connects to a Kafka cluster? (Choose One)
   a. It automatically begins producing messages  
   b. It triggers a rebalance of existing consumer groups  
   c. It initiates a predefined topic creation  
   d. It fetches metadata about partitions and offsets  
   <details><summary>Answer</summary>d - When a consumer connects to a Kafka cluster, it fetches metadata containing information about topics, partitions, and offsets to start processing data.</details>

### 35. What mechanism can be used to scale out consumer applications? (Choose One)
   a. Adding more partitions to existing topics  
   b. Increasing the retention time  
   c. Reducing the batch size  
   d. Adding more broker instances  
   <details><summary>Answer</summary>a - By increasing the number of partitions for a topic, more consumer instances can process messages concurrently, enabling better scalability of consumer applications.</details>

### 36. When a Kafka broker goes down, what temporarily happens to producers attempting to write to its partitions? (Choose One)
   a. Writes are blocked until the broker is back up  
   b. Messages are automatically redirected  
   c. Producing messages fails with an error  
   d. It switches to a backup node  
   <details><summary>Answer</summary>c - If a broker is down, producers attempting to write to its partitions will receive an error since the broker cannot currently accept writes.</details>

### 37. Which property allows Kafka to efficiently handle high volumes of messages? (Choose Two)
   a. Logs are split into segments  
   b. Messages are stored in memory  
   c. Partitioning data  
   d. Data retention policies  
   <details><summary>Answer</summary>a, c - Segmenting logs and partitioning data efficiently distribute message handling across brokers and consumers, allowing Kafka to handle higher message volumes without degradation in performance.</details>

### 38. In using consumer groups, what is the primary impact of adding more consumers? (Choose One)
   a. Increased granularity of data  
   b. Decreased parallel processing  
   c. More efficient message ordering  
   d. Enhanced throughput due to parallel processing  
   <details><summary>Answer</summary>d - By adding more consumers to a consumer group, Kafka allows for parallelism in message processing, which can significantly enhance throughput.</details>

### 39. When does a "session timeout" occur in Kafka? (Choose One)
   a. When the consumer is unable to send a heartbeat  
   b. When the broker is overloaded  
   c. When messages are not consumed within the retention period  
   d. When a topic is deleted  
   <details><summary>Answer</summary>a - A session timeout occurs if the consumer fails to send periodic heartbeats to Zookeeper, which may indicate that it is no longer able to consume messages.</details>

### 40. For a system using Kafka, which deployment pattern helps ensure data availability and durability? (Choose One)
   a. Single broker clusters  
   b. Single consumer groups  
   c. Multi-broker replication  
   d. Higher retention quotas  
   <details><summary>Answer</summary>c - Deploying multiple brokers with replication ensures that even if one broker fails, messages remain available, enhancing both durability and availability.</details>

### 41. What is a potential downside of using a higher replication factor? (Choose One)
   a. Increased latency in data writes  
   b. Lower availability  
   c. Reduced consumer throughput  
   d. Decreased message compression  
   <details><summary>Answer</summary>a - A higher replication factor can lead to increased latency during writes as the message must be written to multiple brokers before being acknowledged as "successful."</details>

### 42. Which of the following are types of consumers in Kafka? (Choose Two)
   a. Standalone consumers  
   b. Managed consumers  
   c. Unmanaged consumers  
   d. Group consumers  
   <details><summary>Answer</summary>a, d - Standalone consumers operate independently, while group consumers belong to a consumer group and share message consumption among its members.</details>

### 43. What does the producer's `enable.idempotence` property ensure? (Choose One)
   a. Each message is sent only once  
   b. Messages are sent in order  
   c. The message size is limited  
   d. Messages can be sent to multiple topics  
   <details><summary>Answer</summary>a - Enabling idempotence guarantees that messages produced by the same producer with the same key are not duplicated, even in the case of retries.</details>

### 44. Why might a producer want to configure a `linger.ms` setting? (Choose One)
   a. To speed up message sending  
   b. To wait for more messages before sending a batch  
   c. To reduce overall latency  
   d. To balance load between brokers  
   <details><summary>Answer</summary>b - By setting `linger.ms`, the producer can wait for a specified amount of time before sending a batch, allowing it to collect more messages and optimize network utilization.</details>

### 45. Which scenarios are ideal for using Kafka Streams? (Choose Two)
   a. Processing data in real-time  
   b. Static data storage  
   c. Analyzing large data sets in batches  
   d. Event-driven applications  
   <details><summary>Answer</summary>a, d - Kafka Streams is designed for real-time processing and is well-suited for event-driven architectures that need to react to incoming stream data.</details>

### 46. What would be the effect of setting a very low `min.insync.replicas` configuration for a topic? (Choose One)
   a. Higher availability  
   b. Increased risk of data loss  
   c. Reduced throughput  
   d. Improved consumer performance  
   <details><summary>Answer</summary>b - Setting a low `min.insync.replicas` increases the risk of data loss, especially during broker outages, as fewer replicas need to acknowledge writes.</details>

### 47. Which command would you use to alter the configuration of an existing topic in Kafka? (Choose One)
   a. kafka-topics --alter  
   b. alter-topic  
   c. modify-kafka-topics  
   d. show-topic-config  
   <details><summary>Answer</summary>a - The command "kafka-topics --alter" is used to modify the configurations of an existing topic.</details>

### 48. What happens when a consumer group rebalances? (Choose One)
   a. All the offsets are reset  
   b. Partitions are reassigned to members of the group  
   c. New topics are created for each partition  
   d. The topic is deleted  
   <details><summary>Answer</summary>b - During a rebalance, partitions are reassigned among the active consumers in a group, allowing for effective distribution of message consumption.</details>

### 49. How can you scale a Kafka Connect setup? (Choose Two)
   a. Increasing the number of tasks  
   b. Adding more connectors  
   c. Increasing the batch size  
   d. Horizontal scaling through multiple workers  
   <details><summary>Answer</summary>a, d - Increasing the number of tasks allows for parallel processing of data, and horizontally scaling by adding more worker nodes enhances the overall capacity of the Kafka Connect setup.</details>

### 50. Which of the following features can be managed through Kafka’s Admin API? (Choose Two)
   a. Topic creation and deletion  
   b. Consumer group rebalancing  
   c. Broker configuration updates  
   d. Access control lists  
   <details><summary>Answer</summary>a, d - The Admin API allows for managing topics and their configurations, and setting up access control lists for security and permissions.</details>

### 51. What does the consumer configuration property `auto.commit.enable` do? (Choose One)
   a. Automatically commits offsets after processing  
   b. Prevents offsets from being committed  
   c. Sets the maximum commit interval  
   d. Enables compression for messages  
   <details><summary>Answer</summary>a - The `auto.commit.enable` property controls whether the consumer will automatically commit offsets after successfully processing messages.</details>

### 52. In Kafka, what could a "NotLeaderForPartition" error indicate? (Choose One)
   a. The partition has no replicas  
   b. The leader for that partition has changed  
   c. The partition has reached its log retention limit  
   d. The consumer is down  
   <details><summary>Answer</summary>b - A "NotLeaderForPartition" error indicates that the current broker is not the leader for the requested partition, typically due to a leadership change.</details>

### 53. What functionality does `describe` command in Kafka provide? (Choose One)
   a. Lists the logs of existing topics  
   b. Shows the configuration of a topic  
   c. Displays all consumer group members  
   d. Provides an overview of producer metrics  
   <details><summary>Answer</summary>b - The `describe` command provides detailed configuration and status information for a specified topic in Kafka.</details>

### 54. What impact does enabling "log compaction" have on data retention? (Choose One)
   a. Increases storage usage  
   b. Removes older messages for each key  
   c. Makes data retrieval slower  
   d. Allows for unlimited data storage  
   <details><summary>Answer</summary>b - Log compaction periodically removes older messages while retaining only the latest version for each unique message key, thus maintaining relevant data without using excess storage.</details>

### 55. In a high-load scenario, consumers may decide to skip messages. What impact can this have on downstream systems? (Choose One)
   a. Data consistency issues  
   b. Improved throughput  
   c. Faster processing  
   d. Increased consumer lag  
   <details><summary>Answer</summary>a - Skipping messages can lead to data consistency issues downstream since the systems relying on complete data sets may encounter incomplete information.</details>

### 56. How can Kafka Connect be used to stream data into Kafka? (Choose One)
   a. By writing a custom producer application  
   b. By using source connectors  
   c. By changing topic configurations  
   d. By setting up manual data ingestion processes  
   <details><summary>Answer</summary>b - Kafka Connect uses source connectors to plug data into Kafka from various external systems, bringing the data into the Kafka ecosystem.</details>

### 57. Which of the following is a recommended practice for managing Kafka offsets? (Choose Two)
   a. Committing offsets after processing messages  
   b. Reading messages in a single-threaded manner only  
   c. Using manual offset management  
   d. Committing offsets before processing messages  
   <details><summary>Answer</summary>a, c - It's recommended to commit offsets after successfully processing messages to ensure accurate tracking, and using manual offset management allows for greater control over message handling.</details>

### 58. How does partitioning of topics in Kafka improve performance? (Choose One)
   a. By grouping messages together  
   b. By allowing parallel reads and writes  
   c. By ensuring message security  
   d. By compressing data sizes  
   <details><summary>Answer</summary>b - Partitioning enables concurrent reads and writes, as different consumers can process different partitions simultaneously, significantly improving overall performance.</details>

### 59. What should you do to recover from a failed consumer in a consumer group? (Choose One)
   a. Restart the entire consumer group  
   b. Trigger a rebalance within the group  
   c. Increase the number of available partitions  
   d. Wait for the consumer to reconnect automatically  
   <details><summary>Answer</summary>b - Triggering a rebalance redistributes the partitions and allows other available consumers in the group to pick up where the failed consumer left off.</details>

### 60. What does the `request.timeout.ms` configuration define for producers or consumers? (Choose One)
   a. The maximum time to wait for a batch of messages  
   b. The time allocated for fetching metadata  
   c. The time to wait for a consumer or producer acknowledgment  
   d. The amount of time before messages are deleted  
   <details><summary>Answer</summary>c - The `request.timeout.ms` setting defines the maximum time a producer or consumer will wait for an acknowledgment from the broker before considering the request as failed.</details>

### 61. When using Kafka Streams, which of the following components are crucial for processing? (Choose Two)
   a. Stateful processors  
   b. External databases  
   c. Source processors  
   d. Sink processors  
   <details><summary>Answer</summary>a, d - Stateful processors maintain state during message processing, and sink processors output data to Kafka topics or external systems after processing.</details>

### 62. What does Kafka's log compaction feature ensure about messages? (Choose One)
   a. All messages are retained regardless of cleanup policy  
   b. Duplicated messages are discarded  
   c. Messages can only be read once  
   d. Messages can be rapidly deleted  
   <details><summary>Answer</summary>b - Log compaction ensures that duplicate messages are discarded, retaining only the latest version for each message key in the log.</details>

### 63. How can you test whether a Kafka topic is receiving messages correctly? (Choose One)
   a. Create a new topic with a different name  
   b. Produce test messages to the topic and consume them  
   c. Monitor Zookeeper directly for updates  
   d. Alter the topic settings  
   <details><summary>Answer</summary>b - By producing test messages to the topic and then consuming them, you can verify that messages are being received and processed correctly.</details>

### 64. Which of the following can cause data duplication in Kafka? (Choose Two)
   a. Producer retries due to timeout  
   b. Misconfigured consumer group rebalancing  
   c. Topic deletion and recreation  
   d. Low batch size settings  
   <details><summary>Answer</summary>a, c - Producer retries during timeouts can cause the same message to be sent again, and deleting and recreating a topic can lead to inconsistencies if not managed properly.</details>

### 65. What is the advantage of using scheduled processing in Kafka Streams? (Choose One)
   a. Real-time data processing  
   b. Asynchronous processing of data  
   c. Delaying message handling for later usage  
   d. Guaranteeing accurate message order  
   <details><summary>Answer</summary>c - Scheduled processing allows processing tasks to be deferred, thus enabling delayed message handling and providing more control over data flow.</details>

### 66. How can message brokering configurations affect producer performance? (Choose Two)
   a. Throughput limits based on available resources  
   b. Configuring maximum batch size  
   c. Frequency of message commits  
   d. Use of multi-topic production  
   <details><summary>Answer</summary>a, c - The configuration of resource availability impacts throughput; higher commit frequency may slow down the production process by increasing latency.</details>

### 67. What does the consumer property `enable.auto.commit` control? (Choose One)
   a. Whether offsets are automatically committed  
   b. The number of messages to pre-fetch  
   c. The interval for polling messages  
   d. The number of partitions a consumer can read from  
   <details><summary>Answer</summary>a - The `enable.auto.commit` property controls whether a consumer should automatically commit offsets after messages are processed.</details>

### 68. Which of the following Kafka security features can help prevent unauthorized access? (Choose Two)
   a. ACLs (Access Control Lists)  
   b. Data encryption  
   c. Message compaction  
   d. Producer acknowledgment configurations  
   <details><summary>Answer</summary>a, b - Implementing ACLs helps manage permissions for accessing topics, while data encryption secures the contents of messages in transit.</details>

### 69. When a topic is deleted in Kafka, what happens to its messages? (Choose One)
   a. They are archived indefinitely  
   b. They are deleted instantly without recycling  
   c. They are compacted immediately  
   d. They are retained according to the retention policy  
   <details><summary>Answer</summary>b - When a Kafka topic is deleted, its messages are removed immediately without them being retained, making them unrecoverable.</details>

### 70. In Kafka, what type of events can trigger stateless processing with Kafka Streams? (Choose One)
   a. Only time-based events  
   b. Events arriving on a scheduled basis  
   c. Any incoming message stream  
   d. Periodic batch jobs  
   <details><summary>Answer</summary>c - Stateless processing in Kafka Streams can occur in response to any incoming message stream, allowing for real-time transformations or definitions without retaining any state.</details>