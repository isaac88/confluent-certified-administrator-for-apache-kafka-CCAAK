# 1.0 Kafka fundamentals 15% weight

* [Apache Kafka architecture, design principles, and purposes](#apache-kafka-architecture-design-principles-and-purposes)
* [Distributed Systems - Scalability, Fault Tolerance, High Availability](#distributed-systems---scalability-fault-tolerance-high-availability)
* [Primary functions of: Producer, Consumer, Broker](#primary-functions-of-producer-consumer-broker)
* [Meaning of “immutable” log](#meaning-of-immutable-log)
* [Meaning of “committed”](#meaning-of-committed)
* [Topics, Partitions](#topics-partitions)
* [Essential services of Apache Zookeeper](#essential-services-of-apache-zookeeper)
* [Replication, Leaders, Followers](#replication-leaders-followers)
* [Kafka Messages, structure, make-up, metadata](#kafka-messages-structure-make-up-metadata)
* [Kafka Controller](#kafka-controller)
* [Exactly Once Semantics](#exactly-once-semantics)

## Apache Kafka architecture, design principles, and purposes

### Apache Kafka architecture
- [course: Apache Kafka® Internal Architecture - The Foundamentals](https://developer.confluent.io/courses/architecture/get-started/)
- [Redpanda - Kafka Architecture](https://www.redpanda.com/guides/kafka-architecture)
- **Replication** is fundamental to Kafka's architecture.
  - Replication is essential because it enables Kafka to ensure availability and durability in the event of individual node failures.

#### Design Principles

- **Distributed**: Kafka is designed to be **distributed**, allowing it to **scale horizontally** by **adding more brokers** to the cluster.
- **Partitioning**: Kafka topics are divided into partitions, allowing for **parallel processing** and **increased throughput**.
- **Fault Tolerance**: Kafka provides **fault tolerance** through **partition replication**, ensuring that data remains available even if a **broker fails**.
- **Scalability**: Kafka can **scale horizontally** by adding more brokers to the cluster, increasing the capacity **to handle more partitions and consumers**.
- **Durability**: Kafka stores messages on disk, providing durability and allowing consumers to replay messages if needed.
- **High Throughput**: Kafka is **optimized for high throughput**, making it suitable for use cases that require processing large volumes of data.
  - Zero Copy: Kafka uses **zero-copy** techniques to minimize data copying and improve performance.
    - [Medium - Zero Copy. One Of Reason Behind Why Kafka So Fast.](https://medium.com/@ankitsheoran127201/zero-copy-one-of-reason-behind-why-kafka-so-fast-7154c9d74b0a)
- **Low Latency**: Kafka offers **low-latency message delivery**, making it suitable for **real-time data processing** applications.
- **Reliability**: Kafka guarantees message delivery and ordering, ensuring that messages are not lost or duplicated.
  - **Kafka Guarantees**:
    - Message ordering within a partition.
    - Produceed messages are considered "commited" when they are written to the partition on all of its in-sync replicas (though they may not necessarily be flushed to disk).
    - Commited messages will not be lost, even if a broker fails at least one in-sync replica remains alive.
    - Consumer can only read commited messages.

#### Purposes

- **Activity tracking**: Kafka can be used to track user activity, log events, and monitor system performance.
- **Messaging**: Kafka is used for messaging between applications, allowing systems to communicate and exchange data.
- **Data Streaming**: Kafka is commonly used for real-time data streaming, allowing applications to publish and consume data in real-time.
- **Event Sourcing**: Kafka can be used for event sourcing, storing a log of events that can be replayed to rebuild the state of an application.
- **Log Aggregation**: Kafka is used for log aggregation, collecting logs from multiple sources and storing them in a centralized location.
- **Metrics Collection**: Kafka can be used for metrics collection, allowing applications to publish metrics data for monitoring and analysis.
- **Change Data Capture (CDC)**(Commit log): Kafka is used for change data capture, capturing and streaming changes to databases in real-time.
- **Microservices Communication**: Kafka can be used for communication between microservices, allowing services to exchange messages and events.
- **Data Integration**: Kafka is used for data integration, enabling data pipelines to move data between systems and applications.
- **Real-time Analytics**: Kafka is used for real-time analytics, allowing applications to process and analyze data in real-time.


## Distributed Systems - Scalability, Fault Tolerance, High Availability

### Scalability in Kafka
- **Scalability** in Kafka refers to the ability of the Kafka cluster to handle increased loads by adding more brokers, topics, or partitions.
  - [course: Apache Kafka® Internal Architecture - Cluster Elasticity](https://developer.confluent.io/courses/architecture/cluster-elasticity/)
  - **Topic Partitioning**:
    - Kafka topics are divided into partitions, allowing for parallel processing and increased throughput.
    - Each partition can be replicated across multiple brokers for fault tolerance.
  - **Horizontal Scalability**:
    - Adding more brokers to a Kafka cluster increases the capacity to handle more partitions and consumers.
    - Producers and consumers can be scaled independently based on their load.
  - **Partition Count**: Choose an optimal number of partitions for a topic based on expected load and consumer parallelism.
    - **Recommended**: To define a good number of partitions initially since increasing the number of partitions later can be complex due it could impact the ordering of messages.
  - **Consumer Groups**: Utilize consumer groups to distribute the load among multiple consumers, allowing them to read from different partitions simultaneously.

### Fault Tolerance in Kafka
- **Fault Tolerance** in Kafka ensures that the system continues to operate correctly even in the event of broker failures or other component failures.
- **Replication**:
  - Each partition can be configured with a replication factor, which defines how many copies of the partition exist across different brokers.
  - If a broker fails, other brokers with replicas can take over, ensuring data availability.
  - `default.replication.factor` (Broker config) The default replication factor for automatically created topics.
  - `replicator.factor`: (Topic config) The replication factor for the internal changelog topics created by the Streams API.
  - `offsets.topic.replication.factor`: (Broker config) The replication factor for the offsets topic.
- **In-Sync Replicas (ISR)**:
  - Replicas that are fully caught up with the leader are part of the ISR.
  - Kafka will only **accept writes** if the number of in-sync replicas meets the `min.insync.replicas` configuration.
- **Set Appropriate Replication Factors**: Use a replication factor of at least 3 for production environments to ensure high availability and fault tolerance.
- **Monitor ISR**: Regularly monitor the ISR to ensure that replicas are in sync with the leader.

### High Availability in Kafka
- **High Availability** in Kafka ensures that the system remains accessible and operational with minimal downtime.
- **Broker Redundancy**:
  - Deploy multiple brokers in a Kafka cluster to prevent a single point of failure.
  - Use **rack awareness** to spread replicas across different racks or availability zones.
- **Automatic Leader Election**:
  - Kafka automatically elects a new leader for a partition if the current leader fails, ensuring continued availability.
    - The **Cluster Controller** is responsible for leader election.
- **Cluster Monitoring**: Implement monitoring tools (e.g., Confluent Control Center, Prometheus) to track the health and performance of the Kafka cluster.
- **Configuration Tuning**: Optimize configurations such as `unclean.leader.election.enable` to control how leader elections are handled during broker failures.

## Primary functions of: Producer, Consumer, Broker

Apache Kafka provides built-in client APIs designed to help developers create applications that interact seamlessly with Kafka.

Kafka uses a **binary wire protocol**, allowing applications to read from or write to Kafka by transmitting the appropriate **byte sequences** to Kafka’s network port.

### Producer

- [Redpanda - Kafka producer](https://www.redpanda.com/guides/kafka-architecture-kafka-producer)

#### Steps of a Kafka `ProducerRecord` Workflow

1. **Producer Sends Data**:  
   The producer creates a `ProducerRecord` to write data to Kafka.

2. **Specifying Details**:  
   - The `ProducerRecord` includes the **topic** and the **value** to send.  
   - Optionally, the producer can also specify a **key** and/or a **partition**.

3. **Serialization**:  
   Once the `ProducerRecord` is sent, the producer first **serializes** the key and value into **ByteArrays** to ensure they can be transmitted over the network.

4. **Partition Assignment**:  
   - If a partition is specified in the `ProducerRecord`, the **partitioner** bypasses selection and directly uses the specified partition.  
   - If no partition is specified, the partitioner selects one, typically using the key from the `ProducerRecord` (if provided). The producer now knows the **topic** and **partition** for the record.

5. **Batching**:  
   The producer adds the record to a **batch** of records destined for the same topic and partition.

6. **Sending to Brokers**:  
   A separate thread handles the transmission of these batches to the appropriate Kafka brokers.

7. **Broker Response**:  
   - Once the broker receives the messages, it sends back a response.  
   - If successful, it returns a `RecordMetadata` object, including the **topic**, **partition**, and **offset** of the record within the partition.  
   - If an error occurs, the broker sends an error response. The producer may retry sending the record several times before ultimately giving up and returning an error.

- A Kafka producer has three mandatory properties:
  - `bootstrap.servers`: List of host:port pairs of brokers that the producer will use to establish initial connection to the Kafka cluster.
  - `key.serializer`: Name of a class that will be used to serialize the keys of the records we will produce to Kafka.
     The producer will use this class to serialize the key object to a byte array.
     Setting key.serializer is required even if you intend to send only values.
  - `value.serializer`: Name of a class that will be used to serialize the values of the records we will produce to Kafka.
    Class that will serialize the message key object to a byte array, you set value.serializer to a class that will serialize the message value object.
- After creating a producer instance, e.g., `KafkaProducer<String, String> producer = new KafkaProducer<>(properties);`, we can begin sending messages.  
  - There are three main approaches to sending messages:

    1. **Fire-and-Forget**:  
       - The producer sends a message to the server without waiting for confirmation, effectively ignoring whether the message was successfully delivered or not.

    2. **Synchronous Send**:  
       - The `send()` method returns a `Future` object. We use the `get()` method to block execution until the response is received, allowing us to confirm whether the message was successfully delivered.

    3. **Asynchronous Send**:  
       - The `send()` method is called with a callback function. This function is invoked when the Kafka broker sends a response, enabling non-blocking confirmation of the message's status.

#### Producer important parameters

Some parameters have a significant impact on memory use, performance, and reliability of the producers.

- `acks`: Controls the number of partition replicas that must acknowledge receiving the record before the producer considers the write operation successful.
  - `acks=0`: The producer does not wait for a response from the broker before assuming the message was sent successfully. As a result, if an issue occurs and the broker does not receive the message, the producer remains unaware, and the message is lost.
  - `acks=1`: The producer receives a success response from the broker as soon as the leader replica acknowledges receipt of the message. (but not necessarily synced to disk).
    - This setting provides a balance between reliability and performance, as the producer receives confirmation that the message was received by the leader replica.
    - However, **if the leader replica fails before** the message is replicated to the followers, **the message will be lost**.
  - `acks=all`: The producer receives a success response from the broker only after all in-sync replicas have acknowledged receipt of the message.
- `buffer.memory`: This configuration determines the amount of memory the producer allocates for buffering messages that are waiting to be sent to brokers.
- `compression.type`: By default, messages are transmitted without compression. However, this parameter can be adjusted to utilize snappy, gzip, or lz4 compression algorithms, which will compress the data before it is sent to the brokers.
- `retries`: The value of the `retries` parameter determines the number of attempts the producer will make to resend the message before it ultimately gives up and informs the client of a problem. If it's a trasitient error message from the server.
- `batch.size`: This parameter regulates the amount of memory, measured in bytes (not in messages!), allocated for each batch.
- `linger.ms`: The `linger.ms` parameter determines the wait time for additional messages before sending the current batch. The `KafkaProducer` will send a batch of messages either when the current batch reaches its capacity or when the `linger.ms` time limit is met. By default, the producer transmits messages as soon as a sender thread is available, even if only one message is in the batch. By setting `linger.ms` to a value greater than 0, we instruct the producer to pause for a few milliseconds to allow for additional messages to be added to the batch before it is sent to the brokers. Although this approach increases latency, it also enhances throughput, as sending more messages at once reduces the overhead per message.
- `client.id`: This can be any string, which will help the brokers identify messages sent from the client. It is utilized for logging and metrics, as well as for managing quotas.
- `max.in.flight.requests.per.connection`: This parameter regulates the number of messages the producer will transmit to the server without waiting for responses. A higher setting can enhance throughput while increasing memory usage, but excessively high values may reduce throughput by making batching less efficient. Setting this value to 1 ensures that messages are written to the broker in the exact order they were sent, even in the event of retries.
- `timeout.ms, request.timeout.ms, metadata.fetch.timeout.ms`: These parameters dictate how long the producer will wait for a response from the server when sending data (`request.timeout.ms`), as well as when fetching metadata, such as the current leaders for the partitions to which we are writing (`metadata.fetch.timeout.ms`).
- `max.block.ms`: This parameter determines how long the producer will block when invoking `send()` and when explicitly requesting metadata using `partitionsFor()`.
- `max.request.size`: This setting controls the size of a produce request made by the producer. It limits both the maximum size of a single message that can be sent and the total number of messages the producer can include in one request. For instance, with a default maximum request size of 1 MB, the largest message allowed is 1 MB, or the producer can batch up to 1,000 messages that are each 1 KB in size into a single request. Additionally, the broker enforces its own maximum limit on message size (`message.max.bytes`). It is generally advisable to align these configurations to avoid situations where the producer attempts to send messages that the broker will reject due to size constraints.
- `receive.buffer.bytes, send.buffer.bytes`: These settings specify the sizes of the TCP send and receive buffers utilized by the sockets during data transmission and reception. If these values are set to -1, the operating system's default settings will be applied. It is advisable to increase these buffer sizes when producers or consumers are communicating with brokers located in a different data center, as those network connections usually experience higher latency and lower bandwidth.

#### Producer Serializer
- **Custom Serializer**: Instead of developing a custom serializer library from scratch, we recommend utilizing existing generic serialization libraries and their serializers and deserializers, such as JSON, Apache Avro, Thrift, or Protobuf.
- **Avro**: **Key Feature**: One of the most notable features of Avro, which makes it well-suited for use in a messaging system like Kafka, is that when the application producing messages transitions to a new schema, the applications consuming the data can continue to process messages without needing any changes or updates.

#### Producer kafka tools commands
- `kakfa-console-producer.sh`: This tool allows you to produce messages to a Kafka topic.
  - `kafka-console-producer --producer.config client.properties --bootstrap-server localhost:9093 --topic kafka-security-topic`: This command produces messages to a Kafka topic.

### Consumer
- [Redpanda - Kafka consumer group](https://www.redpanda.com/guides/kafka-architecture-kafka-consumer-group)
- A consumer reads data from Kafka.
- **Rebalance**: Moving partition ownership from one consumer to another is referred to as a **rebalance**.
  - [Medium - Apache Kafka Rebalance Protocol, or the magic behind your streams applications](https://medium.com/streamthoughts/apache-kafka-rebalance-protocol-or-the-magic-behind-your-streams-applications-e94baf68e4f2)
- Consumers heartbeats: Consumers maintain membership in a consumer group and their ownership of assigned partitions by sending **heartbeats** to a Kafka broker designated as the **Group Coordinator**.
- poll() method: The consumer uses the `poll()` method to fetch records from Kafka.
- .wakeup(): This method is used to interrupt a blocking call, such as `poll()`, and throw a `WakeupException`. This is useful when you want to shut down a consumer or stop it from blocking indefinitely.

#### Consumer important parameters
- `group.id`: A unique string that identifies the consumer group this consumer belongs to.
- `fetch.min.bytes`: The minimum amount of data the server should return for a fetch request. If insufficient data is available, the request will wait `min.fetch.bytes` until the minimum amount of data is available.
- `fetch.max.wait.ms`: By configuring `fetch.min.bytes`, you instruct Kafka to wait until it has sufficient data to send before responding to the consumer. The `fetch.max.wait.ms` parameter allows you to control how long Kafka will wait. By default, Kafka waits up to 500 ms, which can introduce up to 500 ms of additional latency if there isn’t enough data available in the Kafka topic to meet the minimum data requirement. 
To limit potential latency—especially if there are SLAs governing the maximum latency of the application—you can set `fetch.max.wait.ms` to a lower value. For example, if you set `fetch.max.wait.ms` to 100 ms and `fetch.min.bytes` to 1 MB, Kafka will receive a fetch request from the consumer and will respond with data either when it has 1 MB to return or after 100 ms, whichever occurs first.
- `max.partition.fetch.bytes`: The maximum amount of data the server should return for a fetch request. This setting can be used to control the maximum amount of data the consumer will receive in a single request.
If the volume of data returned by a single `poll()` is very large, it may take the consumer a longer time to process the data. This can cause delays in reaching the next iteration of the poll loop, potentially leading to a session timeout. To address this issue, you have two options: either lower `max.partition.fetch.bytes` or increase the session timeout.
- `session.timeout.ms`: The maximum amount of time the consumer can be **out of contact** with the broker before it is **considered dead** and its partitions are reassigned to another consumer in the group.
- `auto.offset.reset`: This parameter determines what happens when there is no initial offset or the current offset no longer exists on the server. The default behavior is to reset the offset to the latest offset. However, you can also set it to the earliest offset or to none, in which case an error will be thrown.
- `enable.auto.commit`: This parameter controls whether the consumer’s offset is automatically committed to the broker. If set to true, the consumer will automatically commit the offset periodically. If set to false, the consumer must manually commit the offset.
- `partition.assignment.strategy`: This parameter allows you to specify the strategy used by the consumer group coordinator to assign partitions to consumers. The default strategy is `org.apache.kafka.clients.consumer.RangeAssignor`, which assigns partitions based on the range of partition IDs. You can also use the `org.apache.kafka.clients.consumer.RoundRobinAssignor`, which assigns partitions in a round-robin fashion.
  - [Medium - Understanding Kafka partition assignment strategies and how to write your own custom assignor](https://medium.com/streamthoughts/understanding-kafka-partition-assignment-strategies-and-how-to-write-your-own-custom-assignor-ebeda1fc06f3)
- `client.id`: This can be any string, which will help the brokers identify messages sent from the client. It is utilized for logging and metrics, as well as for managing quotas.
- `max.poll.records`: This parameter controls the maximum number of records returned in a single call to `poll()`. By adjusting this value, you can control the amount of data the consumer processes in each iteration of the poll loop. If the volume of data returned by a single `poll()` is very large, it may take the consumer a longer time to process the data. This can cause delays in reaching the next iteration of the poll loop, potentially leading to a session timeout. To address this issue, you have two options: either lower `max.partition.fetch.bytes` or increase the session timeout.
- `receive.buffer.bytes and send.buffer.bytes`: These settings specify the sizes of the TCP send and receive buffers utilized by the sockets during data transmission and reception. If these values are set to -1, the operating system's default settings will be applied. It is advisable to increase these buffer sizes when producers or consumers are communicating with brokers located in a different data center, as those network connections usually experience higher latency and lower bandwidth.

#### Consumer kafka-tools commands
- `kafka-consumer-groups.sh --bootstrap-server  localhost:9093 --describe --group <GROUP-ID>`: [Describe example] This tool allows you to list, describe, and delete consumer groups.
  - Outout previous command:
    - `GROUP-ID`: The ID of the consumer group.
    - `TOPIC`: The topic to which the consumer group is subscribed.
    - `PARTITION`: The partition number.
    - `CURRENT-OFFSET`: The current offset of the consumer group. This is the position of the consumer in the partition.
    - `LOG-END-OFFSET`: The log end offset of the partition. This is the offset of the last message in the partition committed to the broker log.
    - `LAG`: The difference between the log end offset and the current offset.
    - `OWNER`: The ID of the consumer.
- `kafka-console-consumer.sh`: This tool allows you to consume messages from a Kafka topic.

### Broker
- [course: Apache Kafka® Internal Architecture - Inside the Apache Kafka Broker](https://developer.confluent.io/courses/architecture/broker/)

## Meaning of “immutable” log
- **Immutable Log**: Kafka maintains an immutable log of messages for each partition. Once a message is written to a partition, it cannot be modified or deleted. This ensures that the order of messages is preserved and that messages are not lost or altered.
- **Append-Only**: Messages are appended to the end of the log, and once written, they cannot be changed. This allows consumers to read messages in the order they were written and ensures that messages are not lost or modified.

## Meaning of “committed”
- Produced messages are deemed "committed" when they are written to the partition on all of its in-sync replicas (though they may not necessarily be flushed to disk). Producers can choose to receive acknowledgments for sent messages when the message is fully committed, when it is written to the leader, or when it is sent over the network.
- This implies that we have a mechanism to monitor which records have been accessed by a consumer within the group.
- The action of updating the current position in the partition is referred to as a **commit**.
- **Committed Offset**: The offset of the last record that was successfully read by a consumer and processed by the application.
- **Consumer Offset**: The offset of the next record that the consumer will read from the partition.
- **Offset Commit**: The action of updating the current position in the partition to the committed offset.

## Topics, Partitions

### Topics

- **Topics** are the primary mechanism for organizing and categorizing messages in Kafka.
  - **Retention policy**:
    - **Compaction/Compacted**: A topic can be configured for compaction, which retains only the latest message for each key. This is useful for maintaining the latest state of a record, such as the current balance of an account.
        - Clean: The messages that have been compacted before.
        - Dirty: The messages that have been written after the last compaction.
      - The **compact** policy never compacts the current segment. Messages are eligible for compaction only in inactive segments.
      - Compaction can affect the read and write **performance** of a topic.
    - **Delete**: The default retention policy is to delete messages after a certain period of time.

### Partitions

- [Redpanda - Kafka partition strategy](https://www.redpanda.com/guides/kafka-tutorial-kafka-partition-strategy)
- Apache Kafka preserves the order of messages within a partition.
- If maintaining order is essential, it is recommended to set `in.flight.requests.per.session=1`. This ensures that while a batch of messages is being retried, no additional messages will be sent, as this could disrupt the correct order.
- When a topic is created, Kafka first determines how to allocate the partitions among the brokers.
- **Partitioning** is the process of dividing a topic into multiple partitions, each of which can be replicated across multiple brokers.
- Partition allocation: 
  - It spread replicas evenly among brokers
  - Each partition, each replica is on a different broker
  - If the brokers have rack information, Kafka will assign the replicas for each partition to different racks whenever possible. 
    This approach ensures that an event leading to downtime for an entire rack does not result in complete unavailability of the partitions.
  - The allocation of partitions to brokers does not consider available space or existing load; however, the allocation of partitions to disks does take the number of partitions into account.
- More partitions allow greater parallelism for consumption, but this will also result in more files across the brokers.
- `num.partitions` (Broker config) The default number of log partitions per topic

#### Partitions reassignment 
- [Automatically migrating data to new machines](https://kafka.apache.org/documentation.html#basic_ops_automigrate)
- Tool: Inside the Kafka Tools: `kafka-reassign-partitions.sh`
- It's a good idea to create a manual reassignment plan if we have large topics, since that tools doens't take in account the size of the topics.
  - Also doesn't provide a plan to reduce the number of partitions to migrate from brokers to brokers.
  - So, maybe we endup trusting that tool blindly and we'll strees our Kafka cluster for nothing.

#### Kafka-tools commands
- `kafka-leader-election.sh`: This tool allows you to trigger a leader election for a specific partition.
  - This tells the cluster controller to select the ideal leader for partitions.
  - This is useful when a broker fails, and you want to ensure that the partition leaders are correctly reassigned.
- `kafka-reassign-partitions.sh`: This tool allows you to reassign partitions between brokers.
  - This is useful when you want to balance the load across brokers or move partitions to new brokers.
  - This command can be use to verify the status of the reassignment.
  - It's a best practice to save first the current partition assignment before running this command in order to be able to rollback if something goes wrong.
  - Partition reassigment has a significant impact on the performance of the cluster, so it's recommended to do it during off-peak hours. Breaking reassignment into smaller batches can help to reduce the impact on the cluster.
  - This command also allows to change the replication factor of a topic.

## Essential services of Apache Zookeeper
- [Medium - ZooKeeper: A Detailed Explanation, Advantages, Real-World Use Cases, and Alternatives](https://medium.com/@devcorner/zookeeper-a-detailed-explanation-advantages-real-world-use-cases-and-alternatives-66636a721d22)
- [Official docs Zookeper - Use Cases](https://zookeeper.apache.org/doc/current/zookeeperUseCases.html)
- `zookeeper.session.timeout.ms`: For clusters using Zookeeper, liveness is determined indirectly through the existence of an **ephemeral node which is created by the broker on initialization** of its Zookeeper session.

  If the **broker loses its session after failing to send heartbeats to Zookeeper** before expiration of `zookeeper.session.timeout.ms`, then the node gets deleted.

  The controller would then notice the node deletion through a **Zookeeper watch** and mark the broker offline.

## Replication, Leaders, Followers
- [Hands-Free Kafka Replication: A Lesson in Operational Simplicity](https://www.confluent.io/blog/hands-free-kafka-replication-a-lesson-in-operational-simplicity/)


### Leaders
- Leader replica: Each partition has one replica designated as the **leader**. All produce and consume requests are routed through the leader to ensure consistency.
- Another responsibility of the leader is to determine which follower replicas are up-to-date with it.
- `auto.leader.rebalance.enable=true`: This parameter allows Kafka to automatically rebalance leaders among the brokers in the cluster. If a broker fails, the leader for the partitions on that broker will be reassigned to another broker.
**Preferred Leaders**: The first replica in the list is always designated as the **preferred leader**. This remains true regardless of who the current leader is, even if the replicas have been reassigned to different brokers using the replica reassignment tool.
- **Produce requests** and **fetch requests** must be sent to the leader replica of a partition.

### Followers
- Follower replica: The remaining replicas are referred to as **followers**. They replicate the data from the leader to ensure fault tolerance and high availability.
- Their main responsibility is to replicate messages **from** the **leader** and remain up-to-date with the latest messages that the **leader** has.
- If a leader replica for a partition crashes, one of the follower replicas will be promoted to serve as the new leader for that partition.
- **Out of Sync**: If a replica has not requested a message for more than 10 seconds, or if it has requested messages but has not caught up to the most recent message in over 10 seconds, it is deemed out of sync. Should a replica fail to keep pace with the leader, it will not be eligible to become the new leader in the event of a failure, as it does not contain all the messages.
- **In-Sync Replicas (ISR)**: Replicas that are fully caught up with the leader are part of the ISR. Kafka will only accept writes if the number of in-sync replicas meets the `min.insync.replicas` configuration.
  - Only **in-sync replicas** are eligible to be elected as partition leaders if the current leader fails.
- To stay in sync with the leader, the replicas send **Fetch requests** to the leader, which are the same type of requests that consumers use to consume messages. In response to these requests, the leader sends the messages to the replicas. These Fetch requests include the offset of the next message that the replica wishes to receive and are always processed in order.
- `replica.lag.time.max.ms`: This parameter specifies the maximum time that a replica can lag behind the leader before it is considered out of sync. If a replica does not request a message from the leader within this time frame, it is considered out of sync and will be removed from the ISR.
- `replica.lag.time.max.ms`: This parameter specifies the maximum time that a replica can lag behind the leader before it is considered out of sync. If a replica does not request a message from the leader within this time frame, it is considered out of sync and will be removed from the ISR.


## Kafka Messages, structure, make-up, metadata

#### Kafka Messages
- Kafka messages consist of key-value pairs.
- Ordering:
  - All messages with the same key will be sent to the same partition.
    - This implies that if a process is reading only a subset of the partitions in a topic, all records associated with a single key will be processed by the same process.
  - Messages without key=null no ordering
    - When the key is null and the default partitioner is applied, the record will be randomly assigned to one of the available partitions of the topic. A round-robin algorithm will be employed to evenly distribute the messages across the partitions.
- **Tombstone message**: A message with a null value that is used to delete a key from a compacted topic.
  - **cleaner thread**: The cleaner thread is responsible for removing tombstone messages from the log.

#### Message Structure
- **Key**: An optional field that can be used to determine the partition to which the message will be written.
- **Value**: The actual data of the message.
- **Timestamp**: The timestamp of the message.
- **Headers**: Additional metadata that can be attached to the message.
- Offeset: The offset of the message within the partition.
- Magic Byte: The version of the message format.
- Compression Codec: The codec used to compress the message.
- Key Size: The size of the key in bytes.

#### Index 
- Kafka Index: The index is a file that maps the offset of a message to its physical location in the log. To assist brokers in quickly locating the message for a specific offset.
- The index maps offsets to segment files and their corresponding positions within the file.
- Indexes are also divided into segments, allowing us to delete old index entries when messages are purged.
- Indexes are regenerated automatically, if they are deleted.


## Kafka Controller
- The **controller** is **one** of the Kafka brokers that, in addition to performing the standard broker functions, is responsible for electing partition leaders.
- The first broker that starts in the cluster becomes the **controller** by creating an ephemeral node in ZooKeeper named `/controller`.
- In case of a controller failure, the first node to create the new controller in ZooKeeper becomes the **new controller**, while the other nodes will receive a "node already exists" error.
- The **controller** is responsible for electing leaders among the partitions and replicas whenever it detects that nodes have joined or left the cluster.
- The **controller** uses the epoch number to prevent a "split brain" scenario, where two nodes mistakenly believe that each is the current controller.


## Exactly Once Semantics

- [📺 Apache Kafka® Transactions: Message Delivery and Exactly-Once Semantics](https://www.youtube.com/watch?v=Ki2D2o9aVl8)
- [Transactions - Kafka Internals](https://developer.confluent.io/courses/architecture/transactions)
- [Exactly-Once Semantics Are Possible: Here’s How Kafka Does It](https://www.confluent.io/blog/exactly-once-semantics-are-possible-heres-how-apache-kafka-does-it/)
- [Transactions in Apache Kafka](https://www.confluent.io/blog/transactions-apache-kafka/)
- [Enabling Exactly-Once in Kafka Streams](https://www.confluent.io/blog/enabling-exactly-once-kafka-streams/)
- `enable.idempotence`: This parameter ensures that the producer sends messages to the broker with exactly-once semantics.
- `transactional.id`: This parameter is used to identify the producer in a transaction. It is essential to set this parameter when using transactions.
- **Exactly-Once Semantics**: This guarantees that each message is processed exactly once, even if there are failures during processing.
- **At-Least-Once Semantics**: This guarantees that each message is processed at least once, but it may be processed multiple times.
- **At-Most-Once Semantics**: This guarantees that each message is processed at most once, but it may not be processed at all.
- **Transactional Guarantees**: Kafka provides exactly-once semantics by using transactions. A transaction is a sequence of read and write operations that are executed as a single unit of work. Either all operations in the transaction are completed successfully, or none of them are.
- **Producer Transactions**: To achieve exactly-once semantics, the producer must use transactions. This allows the producer to send messages to Kafka and commit the transaction only if all messages are successfully written to the broker.
