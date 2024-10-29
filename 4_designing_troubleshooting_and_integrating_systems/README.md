# 4.0 Designing, Troubleshooting, and Integrating Systems – 40% Weight

* [Brokers and Zookeeper](#brokers-and-zookeeper)
    * [CPU, RAM, Network, Storage Considerations](#cpu-ram-network-storage-considerations)
* [Number of Nodes](#number-of-nodes)
* [Rack Awareness](#rack-awareness)
* [Kafka Connect](#kafka-connect)
    * Source and Sink Connectors
* [Scalability and High Availability](#scalability-and-high-availability)
* [Business Continuity / DR](#business-continuity--dr)
* [Data Retention]()

## Brokers and Zookeeper

### Zookeeper

* [📺 Zookeeper Configuration](https://www.udemy.com/course/kafka-cluster-setup/)
* [Zookeeper Configuration File Example](./../Apache_Kafka_Series_Kafka_Cluster_Setup_Administration/course_resources/zookeeper/zookeeper.properties)
* [Zookeeper with Kafka](https://learn.conduktor.io/kafka/zookeeper-with-kafka/)
* [Zookeeper Troubleshooting](https://zookeeper.apache.org/doc/current/zookeeperAdmin.html#sc_troubleshooting)
* [Zookeeper Design Deployment](https://zookeeper.apache.org/doc/current/zookeeperAdmin.html#sc_designing)

### Broker

#### Configuration Management
- `read-only` configuration requires broker restart
    - Change the configuration on `server.properties`
        - Kafka uses key-value pairs in the property file format for configuration. These values can be supplied either from a file or programmatically.
    - Rolling restart of the brokers
- https://kafka.apache.org/documentation/#dynamicbrokerconfigs
- [Broker Configs](https://kafka.apache.org/documentation/#brokerconfigs)
    - Important parameters
        - [auto.create.topics.enable](https://kafka.apache.org/documentation/#brokerconfigs_auto.create.topics.enable)
        - [background.threads](https://kafka.apache.org/documentation/#brokerconfigs_background.threads)
        - [delete.topic.enable](https://kafka.apache.org/documentation/#brokerconfigs_delete.topic.enable)
        - [log.flush.interval.messages](https://kafka.apache.org/documentation/#brokerconfigs_log.flush.interval.messages)
        - [log.retention.hours](https://kafka.apache.org/documentation/#brokerconfigs_log.retention.hours)
        - [message.max.bytes](https://kafka.apache.org/documentation/#brokerconfigs_message.max.bytes)
        - [min.insync.replicas](https://kafka.apache.org/documentation/#brokerconfigs_min.insync.replicas)
        - [num.io.threads](https://kafka.apache.org/documentation/#brokerconfigs_num.io.threads)
        - [num.network.threads](https://kafka.apache.org/documentation/#brokerconfigs_num.network.threads)
        - [num.recovery.threads.per.data.dir](https://kafka.apache.org/documentation/#brokerconfigs_num.recovery.threads.per.data.
        dir)
        - [num.replica.fetchers](https://kafka.apache.org/documentation/#brokerconfigs_num.replica.fetchers)
        - [offsets.retention.minutes](https://kafka.apache.org/documentation/#brokerconfigs_offsets.retention.minutes)
        - [unclean.leader.election.enable](https://kafka.apache.org/documentation/#brokerconfigs_unclean.leader.election.enable)
        - [zookeeper.session.timeout.ms](https://kafka.apache.org/documentation/#brokerconfigs_zookeeper.session.timeout.ms)
        - [broker.rack](https://kafka.apache.org/documentation/#brokerconfigs_broker.rack)
        - [default.replication.factor](https://kafka.apache.org/documentation/#brokerconfigs_default.replication.factor)
        - [num.partitions](https://kafka.apache.org/documentation/#brokerconfigs_num.partitions)
        - []()

#### CPU, RAM, Network, Storage Considerations

#### OS

- [📺 40. Kafka Performance: OS (Operating System)](https://www.udemy.com/course/kafka-cluster-setup/)
- [OS](https://kafka.apache.org/documentation/#os)
- Use Unix systems, tested on Linux and Solaris.
- We recommend at least 100,000 allowed file descriptors for the broker processes as a starting point.
- Run Kafka and Zookeeper independently; avoid putting them on the same VM.

#### CPU

- [39. Kafka Performance: CPU](https://www.udemy.com/course/kafka-cluster-setup/)
- [Find all the CPU-related subjects in the docs](https://kafka.apache.org/documentation/)
- In some cases, the bottleneck is not CPU or disk but network bandwidth.
- SSL data in transit causes CPU load due to encrypting/decrypting the message payload.
- Avoid letting the Kafka Broker compress messages; instead, let the producers and consumers handle it to reduce CPU load on the broker side.
- Monitor Java GC closely to avoid long pauses.

#### RAM

- [📺 38. Kafka Performance: RAM](https://www.udemy.com/course/kafka-cluster-setup/)
- [Understanding Linux OS Flush Behavior](https://kafka.apache.org/documentation/#linuxflush)
- Understand the importance of using `pagecache`:
    - It improves Kafka performance by acting as a memory buffer before data is written to disk.
    - Java Heap Memory is used for the Kafka Java process.
    - The rest of the available free RAM is used for the `pagecache`.
- Recommended to have Kafka broker instances with a minimum of 8GB in production, preferably 16GB or 32GB.
- Disable SWAP for Kafka: set `vm.swappiness=0` or `vm.swappiness=1`.

#### Network

- [📺 37. Kafka Performance: Network](https://www.udemy.com/course/kafka-cluster-setup/)
- [Operationalizing ZooKeeper](https://kafka.apache.org/documentation/#zkops)
- Latency is critical in Kafka.
- Place Kafka Brokers and Zookeeper as close as possible, ideally within the same region (for cloud setups).
- Avoid placing all components in the same AZ or rack, as it increases the risk of failure, though it may reduce latency.
- Bandwidth is key in Kafka.
- The network can be a bottleneck.
- Ensure sufficient bandwidth to handle multiple connections and TCP requests.
- Guarantee high network performance.
- Monitor the network to identify when it becomes a bottleneck.

#### Storage Considerations

- [📺 36. Kafka Performance: I/O](https://www.udemy.com/course/kafka-cluster-setup/)
- [Disks and Filesystem](https://kafka.apache.org/documentation/#diskandfs)
- [Filesystem Selection](https://kafka.apache.org/documentation/#filesystems)
- Reads are done sequentially; use a disk type that matches this requirement.
- Format drives as XFS.
- If there is a read/write throughput bottleneck:
    - Mount multiple disks in parallel for Kafka.
    - Use the configuration: `log.dirs=/disk1/kafka-logs,/disk2/kafka-logs...`.
- Kafka performance remains constant regardless of the amount of data stored.
    - Expire data quickly (default: 1 week).
    - Monitor disk performance.

### Number of Nodes
🚧

### Rack Awareness
🚧

### Kafka Connect
🚧

#### Scalability and High Availability

- [📺 42. Running Kafka in Production on AWS](https://www.udemy.com/course/kafka-cluster-setup/)
    - Separate intances between AZs
    - Use `st1` EBS volumes for best price / performance ratio
    - Mount multiple EBS volumes to the same broker if we need to scale
    - Use `r4.xlarge` or `m4.2xlarge` EBS optimize instances
    - Use DNS names or fixed IP's for the brokers to don't impact the clients.

### Business Continuity / DR
🚧
Mirror maker

### Data Retention
🚧