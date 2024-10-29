### * [1. Apache Kafka Series - Learn Apache Kafka for Beginners v3](https://www.udemy.com/course/apache-kafka)

#### Understand the Basics of Kafka
- [Pending: Key theoretical topics to be added]

#### Practice Assessments
- Complete all quiz tests until you achieve a satisfactory score.
- Engage in all hands-on exercises to deepen your understanding of how Producers and Consumers operate within Kafka.

#### Producer Configuration
- Familiarize yourself with key Producer settings to enhance performance, efficiency, and reliability:
  - **Important Settings:**
    - `retries`: Number of attempts to resend a message if it fails.
    - `batch.size`: Maximum size of a batch of messages that can be sent.
    - `linger.ms`: Time to wait before sending a batch if it’s not full.
    - **Idempotence**: Ensures that messages are not duplicated.
    - **Compression**: Reduces message size for storage and transmission.
    - **Partitioner Behavior**: Determines how messages are distributed across partitions.
    - `acks`: Defines the number of acknowledgments the leader must receive before considering a request complete.

#### Consumer Configuration
- Understand key Consumer settings to optimize performance, efficiency, and reliability:
  - [Pending: Key settings parameters to be added]

#### Schema Registry
- Understand the purpose of the Schema Registry and the principles of schema evolution.

#### Kafka Architecture
- Grasp the basic Kafka architecture to select the appropriate Kafka API for specific use cases.

#### Partitioning Strategy
- Determine the number of partitions needed for your topics.
- Assess the impact of changing the number of partitions or ISR (In-Sync Replicas) after the topic has been created and is in use.

#### Replication Factors
- Decide on the replication factor for your topics:
  - **Key Concepts:**
    - `acks=all`: Ensures that the leader and all in-sync replicas acknowledge the message.
    - `min.insync.replicas`: Minimum number of replicas that must acknowledge a write for it to be considered successful.

#### Limits on Partitions
- Understand the limits on partitions per broker and at the cluster level.

#### Topic Naming Recommendations
- Follow a naming convention: `<message type>.<dataset name>.<data name>.<data format>`
  - Example: `db.db_name.table_name.avro`

#### Real-World Applications of Kafka
- Analyze how Kafka can be applied to real-world scenarios:
  - Given a business need, determine the appropriate Kafka architecture to implement.

#### Kafka Administration
- **Broker Requirements**
  - How many brokers do we need?
  - What kind of Kafka solution do we need? Self-managed or managed solution?

- **Key Metrics**
  - Under-replicated partitions
  - Request handlers: I/O, network, overall utilization
  - Request timing: How long it takes to reply to a request; latency issues.

- **Kafka Operations and Their Impact**
  - Understand how to perform the following operations:
    - Rolling restart of brokers
    - Updating configurations
    - Rebalancing partitions
    - Increasing replication factor
    - Adding a broker
    - Replacing a broker
    - Removing a broker
    - Upgrading a Kafka cluster with zero downtime

- **Default Security Settings**
  - By default, Kafka has NO:
    - Authentication
    - Authorization
    - Encryption in transit
    - Plaintext 9092 port

- **Authentication Mechanisms**
  - Which authentication mechanisms can we use?

- **Authorization in Kafka**
  - How can we define what a valid identity can do inside Kafka? (Authorization using ACLs)

- **Multi-Cluster and Replication Setup**
  - How can we achieve a multi-cluster and replication setup?
    - Note: Replication doesn't preserve offsets, only data.
    - What kinds of replication architectures could we implement? (Pros/Cons)

- **Partitions and Segments**
  - Partitions are made up of segments:
    - `log.segment.bytes`: Default 1GB
      - Error: Too many open files.
    - `log.segment.ms`: Default 1 week
    - Segments come with two indexes:
      - Offset position index
      - Timestamp to offset index

- **Log Cleanup Policy**
  - Understand the log cleanup policy: **Delete** & **Compact**
    - **Delete:**
      - `log.retention.hours`: Default 168 hours (1 week)
      - `log.retention.ms`: `log.retention.minutes`; takes precedence over `log.retention.hours`
      - `log.retention.bytes`: Default -1 (infinite)
    - **Compact:**
      - A process to compact segments into a new active segment (compacted).
      - Retains the latest value of a key indefinitely (no history of a specific key).
      - Log compaction doesn't change the offset; it only removes old keys if a new one is committed.
      - Message ordering is preserved.
      - Offsets are immutable; offsets are skipped if the message has been deleted.
      - `delete.retention.ms`: Default 24 hours; consumers can still see messages after their deletion.
      - Does not prevent read duplication; compaction occurs later on.
      - `log.cleanup.policy=compact` is impacted by:
        - `segment.ms` (default 7 days): Max amount of time to wait to close an active segment.
        - `segment.bytes` (default 1GB): Max size of a segment.
        - `min.compaction.lag.ms` (default 0): How long to wait before a message can be compacted.
        - `delete.retention.ms` (default 24 hours): Wait before deleting data marked for compaction.
        - `min.cleanable.dirty.ratio` (default 0.5): A higher value means less efficient cleaning; a lower value means the opposite.
- `unclean.leader.election.enable=true` Really dangerous param, it allow to start producing to non-ISR partitions
- Avoid send messages to Kafka bigger that default limit of 1MB/message per topic.
    - Instead use Kafka topic as an index metadata and store big objects in another storage solution, like S3.
    - How to send large messages in Kafka? e.g. 10MB. Params to modify.
        - Broker: `message.max.bytes`
        - Topic: `max.message.bytes`
        - Broker: `replica.fetch.max.bytes`
        - Consumer: `max.partition.fetch.bytes``
        - Producer: `max.request.size`

