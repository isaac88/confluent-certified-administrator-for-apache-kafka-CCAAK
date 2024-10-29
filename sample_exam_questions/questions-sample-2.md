# Confluent Certified Administrator for Apache Kafka (CCAAK) practise exam questions - sample 2

## Questions

### 1. What is the primary purpose of a Kafka topic? (Choose One)
   a. To store data indefinitely  
   b. To partition data for better performance  
   c. To categorize messages in a stream  
   d. To manage broker configurations  
   <details><summary>Answer</summary>b - The primary purpose of a Kafka topic is to categorize messages, which allows for better partitioning and organization of data streams.</details>

### 2. In Kafka, what does the term “consumer group” refer to? (Choose One)
   a. A set of topics managed together  
   b. A group of consumers sharing the same group ID  
   c. A collection of producer instances  
   d. A single consumer instance  
   <details><summary>Answer</summary>b - A consumer group is formed when multiple consumers work together by sharing the same group ID, enabling load balancing of message consumption.</details>

### 3. Which feature in Kafka provides fault tolerance for message delivery? (Choose One)
   a. Replication  
   b. Serialization  
   c. Compression  
   d. Partitioning  
   <details><summary>Answer</summary>a - Replication ensures that messages are stored on multiple brokers, providing fault tolerance in case of broker failures.</details>

### 4. How is a partition determined for a message? (Choose One)
   a. Randomly based on available brokers  
   b. Using a partitioning strategy specified by the producer  
   c. Based on message length  
   d. Always sends to the first partition  
   <details><summary>Answer</summary>b - A partition is determined based on a partitioning strategy defined by the producer, allowing for controlled distribution of messages.</details>

### 5. What does the "offset" in Kafka represent? (Choose One)
   a. The timestamp of the message  
   b. The position of the message in a partition  
   c. The size of the message  
   d. The ID of the message producer  
   <details><summary>Answer</summary>b - The offset is a unique identifier for each message within a partition, indicating its position in that partition's log.</details>

### 6. In Kafka, when is batch processing advantageous? (Choose One)
   a. When only a few messages are sent  
   b. When messages can be processed in groups for efficiency  
   c. When immediate delivery is required  
   d. When messages are large in size  
   <details><summary>Answer</summary>b - Batch processing allows for greater efficiency by enabling multiple messages to be sent or processed in a single request, reducing overhead.</details>

### 7. Which component is responsible for managing topic partitions and leaders? (Choose One)
   a. Producer  
   b. Consumer  
   c. Zookeeper  
   d. Broker  
   <details><summary>Answer</summary>c - Zookeeper manages the metadata of the Kafka cluster, including which broker is the leader for each topic partition.</details>

### 8. What does the "retention policy" of a Kafka topic control? (Choose One)
   a. The maximum number of consumers  
   b. The duration data is retained in the topic  
   c. The number of partitions a topic can have  
   d. The types of messages allowed  
   <details><summary>Answer</summary>b - The retention policy specifies how long messages can be stored in a topic before they are deleted, ensuring efficient use of storage.</details>

### 9. Which of the following best describes a "leader" in Kafka? (Choose One)
   a. The first broker in a cluster  
   b. A broker responsible for a particular partition  
   c. A consumer that processes all messages  
   d. The coordinator of consumer groups  
   <details><summary>Answer</summary>b - A leader is a broker that handles all reads and writes for a particular partition, coordinating with followers for data consistency.</details>

### 10. How can you ensure that messages are processed in the order they are produced? (Choose One)
   a. Use multiple partitions  
   b. Use a single partition  
   c. Use consumer groups  
   d. Use replication
<details><summary>Answer</summary>b - To maintain the order of messages, a single partition must be used since all messages in a partition have sequential offsets.</details>

### 11. Which of these operations can lead to data loss in Kafka? (Choose One)
 a. No replication  
 b. Synchronous commit  
 c. Producer acknowledgment  
 d. Partition rebalance  
<details><summary>Answer</summary>a - Without replication, if a broker fails, all messages on that broker can be lost, highlighting the importance of replication for durability.</details>

### 12. How is the durability of messages in Kafka ensured? (Choose One)
   a. By using partitions  
   b. Through write-ahead logging  
   c. By increasing the replication factor  
   d. With compression  
<details><summary>Answer</summary>c - Increasing the replication factor ensures that messages are stored on multiple brokers, thus enhancing durability against broker failures.</details>

### 13. What role does the "Zookeeper" play in a Kafka cluster? (Choose One)
   a. Storing messages  
   b. Managing configuration and metadata  
   c. Processing consumer requests  
   d. Producing messages  
<details><summary>Answer</summary>b - Zookeeper is responsible for coordinating distributed applications by managing Kafka's configuration, topic metadata, and leader elections.</details>

### 14. What is the default number of partitions created for a new Kafka topic? (Choose One)
   a. 1  
   b. 3  
   c. 5  
   d. 10  
<details><summary>Answer</summary>a - The default configuration for a new topic in Kafka is typically a single partition unless adjusted during topic creation.</details>

### 15. In Kafka, what does "acknowledgment" from a producer mean? (Choose One)
   a. Acknowledging message receipt by a consumer  
   b. Confirmation of message storage by the broker  
   c. A message that cannot be processed  
   d. A request for more memory  
<details><summary>Answer</summary>b - Acknowledgment from a producer indicates that the broker has successfully received and stored the message, ensuring reliability.</details>

### 16. Which property of a Kafka topic determines how many consumers can read from it simultaneously? (Choose One)
   a. Number of partitions  
   b. Replication factor  
   c. Retention period  
   d. Producer acknowledgment  
<details><summary>Answer</summary>a - The number of partitions directly influences the level of parallelism; more partitions mean more consumers can read from them concurrently.</details>

### 17. What does the "high-water mark" (HW) refer to in Kafka? (Choose One)
   a. The highest offset for in-flight messages  
   b. The last successful message offset for a partition  
   c. The point where messages are deleted  
   d. The size of the message log  
<details><summary>Answer</summary>b - The high-water mark indicates the last acknowledged offset, representing the point up to which messages are considered successfully replicated.</details>

### 18. When a consumer performs a "seek" operation, what does it do? (Choose One)
   a. Reads all messages from a partition  
   b. Moves the consumer's offset to a specific position  
   c. Balances the load among consumers  
   d. Increases the fetch size  
<details><summary>Answer</summary>b - The seek operation allows a consumer to change its offset to a specific position in the log, enabling it to re-read or skip messages.</details>

### 19. What does it mean when a Kafka topic is “compacted”? (Choose One)
   a. To reduce the number of partitions  
   b. To remove old messages while keeping the latest  
   c. To compress message storage  
   d. To apply encryption for security  
<details><summary>Answer</summary>b - Compaction allows Kafka to keep the most recent message for each unique key while discarding older versions, optimizing storage.</details>

### 20. How would you monitor the health of a Kafka cluster? (Choose Two)
   a. Checking consumer lag  
   b. Monitoring Zookeeper metrics  
   c. Analyzing produced message size  
   d. Reviewing JVM garbage collection logs  
<details><summary>Answer</summary>a, b - Monitoring consumer lag helps identify if consumers are keeping up, while Zookeeper metrics indicate broker health and connectivity.</details>

### 21. Which of the following can be a reason for poor consumer performance? (Choose One)
   a. High number of partitions  
   b. Low replication factor  
   c. High consumer group size  
   d. Low message retention  
<details><summary>Answer</summary>c - A high consumer group size can lead to contention and lower throughput if many consumers are trying to read from the same partitions.</details>

### 22. What feature allows Kafka consumers to reprocess historical messages? (Choose One)
   a. Consumer Groups  
   b. Retention Policy  
   c. Message Acknowledgments  
   d. Partitioning  
<details><summary>Answer</summary>b - The retention policy defines how long messages remain available for consumption, allowing consumers to read historical messages within that timeframe.</details>

### 23. Which Kafka protocol manages the interaction between producers and brokers? (Choose One)
   a. HTTP  
   b. TCP  
   c. Multi-Protocol  
   d. Kafka Protocol  
<details><summary>Answer</summary>d - The Kafka Protocol defines the interactions and message formats exchanged between producers and brokers for communication.</details>

### 24. What determines the ordering of messages within a partition in Kafka? (Choose One)
   a. Message timestamp  
   b. Producer ID  
   c. Offset  
   d. Consumer group  
<details><summary>Answer</summary>c - The offset guarantees the order of messages, as each message is sequentially assigned a unique offset within its partition.</details>

### 25. How can you achieve parallel processing in Kafka? (Choose One)
   a. Increase the size of a consumer group  
   b. Add more topics  
   c. Create multiple partitions on a topic  
   d. Use only one partition per topic  
<details><summary>Answer</summary>c - Creating multiple partitions for a topic allows for parallel consumption by distributing the load among different consumers.</details>

### 26. Which Kafka feature allows for a fault-tolerant storage system? (Choose One)
   a. Compression  
   b. Data Partitioning  
   c. Data Replication  
   d. Offset Management  
<details><summary>Answer</summary>c - Data replication ensures that copies of messages are stored on multiple brokers, preserving data availability in case of failures.</details>

### 27. What is the consequence of setting a low log retention period for a Kafka topic? (Choose One)
   a. Increased broker load  
   b. Higher risk of data loss  
   c. Slower message consumption  
   d. Reduced topic performance  
<details><summary>Answer</summary>b - A low retention period increases the risk of losing messages that consumers have not yet processed, potentially leading to gaps in data availability.</details>

### 28. How do Kafka producers inform brokers about the message format? (Choose One)
   a. By including format in message headers  
   b. The broker assumes default format  
   c. By specifying format in the topic configuration  
   d. Through Zookeeper  
<details><summary>Answer</summary>a - Producers can include information about the message format in the message headers, allowing brokers to handle it appropriately.</details>

### 29. What happens if a consumer fails while processing a message? (Choose One)
   a. The message is deleted  
   b. The offset is committed  
   c. The message is re-queued for processing  
   d. The message is skipped  
<details><summary>Answer</summary>c - In the case of a consumer failure, the message will typically be re-queued and can be processed again upon recovery or restart.</details>

### 30. Which setting in Kafka defines how long to keep unconsumed messages? (Choose One)
   a. log.retention.hours  
   b. message.max.bytes  
   c. log.cleanup.policy  
   d. fetch.messages.max  
<details><summary>Answer</summary>a - The "log.retention.hours" setting specifies the duration for which unconsumed messages are retained before being eligible for deletion.</details>

### 31. How is data replication achieved in Kafka? (Choose One)
   a. By sending messages to multiple brokers  
   b. By having multiple consumer nodes  
   c. Through Zookeeper snapshots  
   d. By partitioning topics  
<details><summary>Answer</summary>a - Replication is accomplished by writing the same message to multiple brokers for each partition, ensuring data redundancy.</details>

### 32. In Kafka, what does the term "message key" allow for? (Choose One)
   a. Processing messages in any order  
   b. Routing messages to specific partitions  
   c. Prioritizing message delivery  
   d. Encrypting the message  
<details><summary>Answer</summary>b - The message key is used to designate which partition should receive the message, allowing for controlled routing and partitioning.</details>

### 33. What happens when a consumer reaches the end of a partition? (Choose One)
   a. It closes the partition  
   b. It waits for new messages to arrive  
   c. It restarts reading from the beginning  
   d. It terminates the consumer  
<details><summary>Answer</summary>b - When a consumer reaches the end of a partition, it will wait for new messages to arrive before continuing to poll for data.</details>

### 34. How often should a Kafka broker's configurations be reviewed? (Choose One)
   a. Only initially  
   b. Daily  
   c. Monthly or as needed  
   d. Every week  
<details><summary>Answer</summary>c - Reviewing broker configurations monthly or as needed ensures they align closely with current operational requirements and best practices.</details>

### 35. When processing data in Kafka Streams, which entity is responsible for actually processing the data? (Choose One)
   a. Kafka Broker  
   b. Consumer Group  
   c. Kafka Streams application  
   d. Zookeeper  
<details><summary>Answer</summary>c - The Kafka Streams application designates the necessary logic and framework to process data in real time across defined streams.</details>

### 36. Which command is used to list Kafka topics in the command-line interface? (Choose One)
   a. kafka-topics --list  
   b. list-kafka-topics  
   c. show-topics  
   d. kafka-list-topics  
<details><summary>Answer</summary>a - The command "kafka-topics --list" is used in the command-line interface to list all topics in the Kafka cluster.</details>

### 37. In a log-structured storage system like Kafka, what happens after messages are consumed? (Choose One)
   a. They are deleted immediately  
   b. They are compacted based on retention policy  
   c. They are stored indefinitely  
   d. They are archived to secondary storage  
<details><summary>Answer</summary>b - In Kafka, consumed messages are subject to compaction or deletion based on the retention policy, but they are not deleted immediately upon consumption.</details>

### 38. When using Kafka Connect, what is the primary role of connectors? (Choose One)
   a. To optimize message retention  
   b. To facilitate data ingestion/export to/from Kafka  
   c. To balance loads across consumers  
   d. To monitor Kafka clusters  
<details><summary>Answer</summary>b - Connectors in Kafka Connect are responsible for managing the flow of data either into or out of Kafka from various sources or sinks.</details>

### 39. When does a "rebalance" occur in Kafka consumers? (Choose One)
   a. When messages are produced  
   b. When a new consumer joins or leaves a group  
   c. Only when a topic is created  
   d. When broker configuration changes  
<details><summary>Answer</summary>b - A rebalance occurs when there is a change in the membership of a consumer group, such as a consumer joining or leaving.</details>

### 40. What is the main use of "changelog" topics in Kafka Streams? (Choose One)
   a. For logging consumer activities  
   b. To store the state of processors  
   c. To keep track of message delivery  
   d. For maintaining producer offsets  
<details><summary>Answer</summary>b - Changelog topics record the state of stateful transformations in Kafka Streams, allowing for recovery from failures.</details>

### 41. How can consumers in Kafka guarantee at-least-once delivery semantics? (Choose One)
   a. By increasing the retention period  
   b. By using a unique message key  
   c. By employing sufficient acknowledgments  
   d. By reading from multiple partitions  
<details><summary>Answer</summary>c - At-least-once delivery is obtained by requiring that messages are acknowledged before they are considered successfully processed.</details>

### 42. Which command would you use to produce messages to a Kafka topic from the command line? (Choose One)
   a. kafka-console-producer  
   b. produce-kafka-msg  
   c. kafka-producer-console  
   d. send-to-kafka  
<details><summary>Answer</summary>a - The "kafka-console-producer" command is used to send messages to a specified Kafka topic from the command line.</details>

### 43. In Kafka, what is a “compact” log structure? (Choose One)
   a. A variation of a traditional DAG  
   b. Replaces the oldest messages with the latest entry for a given key  
   c. Merges logs from different partitions  
   d. Splits large messages into smaller messages  
<details><summary>Answer</summary>b - Compacted logs in Kafka keep the most recent message for each unique key, discarding older messages to save space.</details>

### 44. What guarantees message order within a Kafka partition? (Choose One)
   a. Compression techniques  
   b. Consumer implementations  
   c. The use of a single producer  
   d. Broker load balancing  
   <details><summary>Answer</summary>c - The use of a single producer for a partition ensures that messages are produced in a consistent order, as each message receives a sequential offset.</details>

### 45. What does the "clean up policy" configuration do in Kafka? (Choose One)
   a. Controls how logs are deleted  
   b. Determines message producers  
   c. Manages consumer configurations  
   d. Specifies partition counts  
   <details><summary>Answer</summary>a - The clean-up policy setting controls how Kafka handles message deletion, either through log compaction or deletion based on retention settings.</details>

### 46. What is the purpose of Kafka Streams API? (Choose One)
   a. Web framework for Kafka applications  
   b. Batch processing of data  
   c. Real-time processing and transformation of data  
   d. For managing Kafka configurations  
   <details><summary>Answer</summary>c - The Kafka Streams API is designed to enable real-time processing and transformation of data streams, allowing developers to build powerful stream processing applications.</details>

### 47. Which of the following is a common way to create a new topic in Kafka? (Choose One)
   a. Using the admin API  
   b. Manually in Zookeeper  
   c. By sending a message to a non-existing topic  
   d. Automatically by producers  
   <details><summary>Answer</summary>a - Topics are typically created through the Kafka Admin API, which allows for easy configuration and management.</details>

### 48. How does Kafka ensure message delivery to consumers during a failure? (Choose One)
   a. With distributed processing  
   b. By indexing messages  
   c. Through message replication  
   d. By reducing partition sizes  
   <details><summary>Answer</summary>c - Message replication ensures that if one broker fails, consumers can retrieve messages from another broker holding copies of the messages.</details>

### 49. What could potentially lead to an “Out of Memory” error in Kafka brokers? (Choose One)
   a. High-volume data ingestion  
   b. Increased number of partitions  
   c. Low consumer throughput  
   d. Misconfigured retention settings  
   <details><summary>Answer</summary>a - High-volume data ingestion can overwhelm broker memory, especially if messages are retained longer than intended or resources are insufficient.</details>

### 50. Which command is used to describe the properties of a specific topic? (Choose One)
   a. kafka-topics --describe  
   b. describe-kafka-topics  
   c. kafka-topic-info  
   d. show-topic-properties  
   <details><summary>Answer</summary>a - The "kafka-topics --describe" command provides detailed information about a specific topic's configuration and partitions.</details>

### 51. How can a user obtain metadata about the Kafka cluster? (Choose One)
   a. Using the Kafka Producer API  
   b. Through the Kafka Streams API  
   c. By calling the AdminClient  
   d. Directly from Zookeeper  
   <details><summary>Answer</summary>c - The AdminClient API allows users to retrieve metadata about the cluster and its topics programmatically.</details>

### 52. What does a "mirror" in Kafka refer to? (Choose One)
   a. A duplicate message  
   b. A replicated Kafka cluster  
   c. A logging feature  
   d. A broker configuration  
   <details><summary>Answer</summary>b - MirrorMaker is a Kafka tool designed to replicate messages from one Kafka cluster to another, creating a 'mirror' of the data.</details>

### 53. What is a "backoff" in the context of Kafka consumers? (Choose One)
   a. Increasing message rate  
   b. Waiting period before retrying failed message reads  
   c. Enhanced compression  
   d. A type of message acknowledgement  
   <details><summary>Answer</summary>b - A backoff specifies the delay between retries when a consumer fails to read messages, helping to reduce the load on the broker.</details>

### 54. When using a Kafka producer, which option can help improve data ingesting speed? (Choose One)
   a. Setting a high batch size  
   b. Reducing the compression ratio  
   c. Lowering the maximum message size  
   d. Increasing the replication factor  
   <details><summary>Answer</summary>a - Setting a high batch size allows the producer to send multiple messages together, improving throughput and reducing round-trip time.</details>

### 55. How can you ensure exactly-once semantics in Kafka? (Choose One)
   a. Using Kafka Streams with state stores  
   b. By using multiple consumers  
   c. Limiting the number of messages per batch  
   d. By committing offsets before processing  
   <details><summary>Answer</summary>a - Kafka Streams provides mechanisms for managing state and ensuring exactly-once processing by leveraging state stores and handling transactions.</details>

### 56. Which method provides the consumer with the position of the last committed message? (Choose One)
   a. Through acknowledgments  
   b. By accessing the consumer offsets topic  
   c. Via a separate log  
   d. By polling the broker  
   <details><summary>Answer</summary>b - Consumer offsets for committed messages are tracked in the __consumer_offsets topic, allowing consumers to retrieve their last processed position.</details>

### 57. What does the consumer configuration property `auto.offset.reset` determine? (Choose One)
   a. How long offsets are retained  
   b. What to do when there are no committed offsets  
   c. The order in which messages are processed  
   d. The number of partitions created  
   <details><summary>Answer</summary>b - The `auto.offset.reset` property defines how consumers should behave when there are no valid offsets for them, deciding between starting from the beginning or the latest message.</details>

### 58. What does MQTT stand for, and how does it compare to Kafka? (Choose One)
   a. Message Queuing Telemetry Transport; it is more secure  
   b. Message Queue Telemetry Transport; it requires less configuration  
   c. Multi-Queue Transport; it has no built-in security  
   d. Multi-Message Queue Toolkit; it is faster for small messages  
   <details><summary>Answer</summary>b - MQTT (Message Queue Telemetry Transport) is a lightweight messaging protocol that requires less configuration compared to Kafka, which is designed for high throughput and scalability.</details>

### 59. In Kafka, what happens when the log segment reaches the configured maximum size? (Choose One)
   a. It sends an alert to Zookeeper  
   b. It creates a new log segment and continues writing  
   c. It stops the producer until space is freed  
   d. It deletes the oldest messages  
   <details><summary>Answer</summary>b - Once a log segment reaches its maximum size, Kafka automatically creates a new segment for future writes, allowing continued data ingestion.</details>

### 60. What does serialization refer to in Kafka? (Choose One)
   a. The process of splitting messages  
   b. Converting messages into a byte stream  
   c. Compressing data for storage  
   d. Encrypting messages for security  
   <details><summary>Answer</summary>b - Serialization is the process of converting structured data into a byte format which Kafka can transmit over its network connections.</details>

### 61. What is “Kafka Schema Registry” primarily used for? (Choose One)
   a. To manage message offsets  
   b. To define schema for messages  
   c. To register consumer groups  
   d. To monitor broker health  
   <details><summary>Answer</summary>b - Kafka Schema Registry is used to manage the schemas of the messages to ensure proper parsing and validation across producers and consumers.</details>

### 62. In Kafka, what does “request.timeout.ms” control? (Choose One)
   a. Maximum time for a single request  
   b. How long a consumer can wait for messages  
   c. Maximum time to receive an acknowledgment  
   d. Timeout for broker communication  
   <details><summary>Answer</summary>c - The “request.timeout.ms” configuration controls how long a producer will wait for an acknowledgment from the broker before considering the request as failed.</details>

### 63. Why would you use a “transactional producer” in Kafka? (Choose One)
   a. To create a single message  
   b. To manage consumer offsets  
   c. To ensure atomicity of multiple messages  
   d. To partition messages  
   <details><summary>Answer</summary>c - A transactional producer allows for atomicity when sending multiple messages, ensuring that either all messages are successfully sent or none at all, preventing data inconsistencies.</details>

### 64. In Kafka, under which condition would you encounter the term "stall" with a producer? (Choose One)
   a. When too many messages are created  
   b. When a producer is blocked by buffering  
   c. During a partition reassignment  
   d. When a consumer is overloaded  
   <details><summary>Answer</summary>b - A "stall" occurs when a producer's requests to write messages are delayed due to filled buffers or broker unavailability, causing the producer to be blocked.</details>

### 65. What does the property “enable.auto.commit” control in a Kafka consumer? (Choose One)
   a. Whether consumers can send messages  
   b. How frequently offsets are committed  
   c. If offsets are committed automatically  
   d. If consumers can process concurrently  
   <details><summary>Answer</summary>c - The “enable.auto.commit” property determines if the Kafka consumer should automatically commit offsets after consuming messages, which can affect message processing semantics.</details>

### 66. Which feature is NOT supported in Kafka? (Choose One)
   a. Batch processing  
   b. Message streaming  
   c. Immediate message deletion  
   d. Topic retention  
   <details><summary>Answer</summary>c - Kafka does not support immediate message deletion; messages can only be deleted based on retention policies and configurations.</details>

### 67. How can you improve the performance of message consumption in Kafka? (Choose Two)
   a. Increasing the number of partitions  
   b. Reducing the number of consumers  
   c. Enabling compression on messages  
   d. Using larger fetch sizes  
   <details><summary>Answer</summary>a, d - Increasing partitions allows for more consumers to read in parallel, and larger fetch sizes can enhance throughput by reducing the number of requests.</details>

### 68. What is the main purpose of a "consumer poll loop"? (Choose One)
   a. To buffer incoming messages  
   b. To manage partition reassignment  
   c. To fetch and process messages in a continuous manner  
   d. To commit offsets periodically  
   <details><summary>Answer</summary>c - A consumer poll loop is designed to continuously fetch new messages and process them in real time, ensuring efficient consumption.</details>

### 69. In Kafka, which strategy is used for message delivery reliability? (Choose One)
   a. Load balancing  
   b. Message acknowledgments and retries  
   c. Broker sharding  
   d. Message transformation  
   <details><summary>Answer</summary>b - Ensuring reliable message delivery in Kafka involves using acknowledgments and retry mechanisms for producers and consumers to handle failures.</details>

### 70. How can you visualize data processing flows in Kafka Streams? (Choose One)
   a. Using JMX metrics  
   b. Through the Kafka UI  
   c. By monitoring logs  
   d. At distributed stream processors  
   <details><summary>Answer</summary>b - The Kafka UI provides visual tools for monitoring data flow and processing in Kafka Streams applications, making it easy to understand the architecture.</details>