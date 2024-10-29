# 4.0 Designing, Troubleshooting, and Integrating Systems – 40% Weight

* [Brokers and Zookeeper](#brokers-and-zookeeper)
    * [CPU, RAM, Network, Storage Considerations](#cpu-ram-network-storage-considerations)
* [Number of Nodes](#number-of-nodes)
* [Rack Awareness](#rack-awareness)
* [Kafka Connect](#kafka-connect)
* [Scalability and High Availability](#scalability-and-high-availability)
* [Business Continuity / DR](#business-continuity--dr)
* [Data Retention](#data-retention)

## Brokers and Zookeeper

### Zookeeper

* [📺 Zookeeper Configuration](https://www.udemy.com/course/kafka-cluster-setup/)
* [Zookeeper Configuration File Example](./../resources/Apache_Kafka_Series_Kafka_Cluster_Setup_Administration/course_resources/zookeeper/zookeeper.properties)
    ```zookeeper.properties
    # zookeeper.properties
    # the location to store the in-memory database snapshots and, unless specified otherwise, the transaction log of updates to the database.
    dataDir=/data/zookeeper
    # the port at which the clients will connect
    clientPort=2181
    # disable the per-ip limit on the number of connections since this is a non-production config
    maxClientCnxns=0
    # the basic time unit in milliseconds used by ZooKeeper. It is used to do heartbeats and the minimum session timeout will be twice the tickTime.
    tickTime=2000
    # The number of ticks that the initial synchronization phase can take
    initLimit=10
    # The number of ticks that can pass between
    # sending a request and getting an acknowledgement
    syncLimit=5
    # zoo servers
    # these hostnames such as `zookeeper-1` come from the /etc/hosts file
    server.1=zookeeper1:2888:3888
    server.2=zookeeper2:2888:3888
    server.3=zookeeper3:2888:3888
    ```

* [Zookeeper with Kafka](https://learn.conduktor.io/kafka/zookeeper-with-kafka/)
* [Zookeeper Troubleshooting](https://zookeeper.apache.org/doc/current/zookeeperAdmin.html#sc_troubleshooting)
* [Zookeeper Design Deployment](https://zookeeper.apache.org/doc/current/zookeeperAdmin.html#sc_designing)
- Kafka utilizes Zookeeper for **storing metadata information** about the **brokers**, **topics**,
and **partitions**.
    - Zookeeper **monitors** the brokers that make up the **Kafka cluster**.
    - Kafka brokers rely on Zookeeper to **identify the leader for each partition and topic**, as well as to **conduct leader elections**.
    - Zookeeper holds **configuration details** for **topics** and manages **permissions(ACLS)**.
    - Zookeeper notifies Kafka of any changes, such as the creation of new topics, broker failures, broker recoveries, and topic deletions
- It's **not** a good practise to share the Zookeeper ensemble with other applications inside the same instance.
- Kafka is **sensitive** to Zookeeper latency and timeouts, and an interruption in communications with the
  ensemble will cause the brokers to behave unpredictably.
- This can easily cause multiple brokers to go offline at the same time, should they lose Zookeeper connections,
  which will result in offline partitions
- Zookeeper is used as a recovery mechanism in casae of broker failure.
- Kafka Zookeeper server.properties config
    ```
    # server.properties
    ############################# Zookeeper #############################

    # Zookeeper connection string (see zookeeper docs for details).
    # This is a comma separated host:port pairs, each corresponding to a zk
    # server. e.g. "127.0.0.1:3000,127.0.0.1:3001,127.0.0.1:3002".
    # You can also append an optional chroot string to the urls to specify the
    # root directory for all kafka znodes.
    zookeeper.connect=zookeeper1:2181,zookeeper2:2181,zookeeper3:2181/kafka

    # Timeout in ms for connecting to zookeeper
    zookeeper.connection.timeout.ms=6000
    ```

### Broker

#### Adding a new Broker. What will happen?

- We can add Brokers to **scale horizontally** and also to have **more performance**.
- New added Brokers **don't have** any **topic assign**.
- Topics **Partition Rebalance operation is required** to spread the load equally in the cluster.
- We need to **be sure** that the new added broker is added on the **zookeeper metadata**.

#### Replace a existing Broker keeping the existing data
- We terminate the Broker instance
- Create a new Broker instance
- Attach the available EBS to the new instance
- Start Kafka service on the new Broker instance
- That new instance, ONLY will replicate the data that doesn't have yet.

#### Terminate a Broker definitively
- **Move the partitions leaders to another Broker**
- We need to first **move all the current partitions** from the terminated Broker to **other existing Brokers**.
- Once done, we can terminate the instance.

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
            - The name of the param is the same at topic level.
            - This parameter is used to determine the minimum number of in-sync replicas (ISR) that must acknowledge a write for the write to be considered successful.
            - If the number of in-sync replicas falls below this value, the broker will stop accepting writes until the ISR count is restored.
            - This parameter is used to ensure that data is not lost if a broker fails ( Consistency ).
        - [num.io.threads](https://kafka.apache.org/documentation/#brokerconfigs_num.io.threads)
        - [num.network.threads](https://kafka.apache.org/documentation/#brokerconfigs_num.network.threads)
        - [num.recovery.threads.per.data.dir](https://kafka.apache.org/documentation/#brokerconfigs_num.recovery.threads.per.data.dir)
        - [num.replica.fetchers](https://kafka.apache.org/documentation/#brokerconfigs_num.replica.fetchers)
        - [offsets.retention.minutes](https://kafka.apache.org/documentation/#brokerconfigs_offsets.retention.minutes)
        - [unclean.leader.election.enable](https://kafka.apache.org/documentation/#brokerconfigs_unclean.leader.election.enable)
            - This parameter is used to determine whether a broker can be elected as a leader **if it is NOT in-sync with the ISR**.
            - Setting `unclean.leader.election.enable` to true allows **out-of-sync replicas to become leaders** (known as unclean election), with the understanding that this may result in the **loss of messages**.
            - If set to false(default), the broker **must be in sync with the ISR to be elected as a leader**.
        - [zookeeper.session.timeout.ms](https://kafka.apache.org/documentation/#brokerconfigs_zookeeper.session.timeout.ms)
        - [broker.rack](https://kafka.apache.org/documentation/#brokerconfigs_broker.rack)
        - [default.replication.factor](https://kafka.apache.org/documentation/#brokerconfigs_default.replication.factor)
        - [num.partitions](https://kafka.apache.org/documentation/#brokerconfigs_num.partitions)

#### Troubleshooting

- [DumpLogSegment](https://jaceklaskowski.gitbooks.io/apache-kafka/content/kafka-tools-DumpLogSegments.html): Kafka brokers include the **DumpLogSegment** tool, which enables you to view a partition segment in the filesystem and examine its contents.
    - This tool is useful for debugging and troubleshooting issues with the log segments.
    - `bin/kafka-run-class.sh kafka.tools.DumpLogSegments`: This command will dump the contents of a log segment file to the console.

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

##### Garbage Collector

**What Are Garbage Collector (GC) Pauses?**
In Java (which Kafka runs on), the Garbage Collector (GC) automatically reclaims memory by removing unused objects. 
However, when the GC runs, it sometimes pauses the entire application for cleanup. These pauses are known as GC pauses (or Stop-the-World events).

During a GC pause:
✅ The JVM stops all application threads (Kafka processing halts).
✅ It frees up memory by removing unused objects.
✅ Once completed, the application resumes execution.

**The problem?** If GC pauses are too long, Kafka brokers stop responding, causing delays, leader elections, or even failures. (stop-the-world events)
- Tuning the Java garbage-collection options
- G1 is designed to automatically adjust to different workloads and provide consistent pause times for garbage collection over the lifetime of the application.
- It also
handles large heap sizes with ease by segmenting the heap into smaller zones and not
collecting over the entire heap in each pause.
- There are two configuration options for G1 used to adjust its performance:
    - `MaxGCPauseMillis`: This option specifies the preferred pause time for each garbage-collection cycle.
It is not a fixed maximum—G1 can and will exceed this time if it is required. This
value defaults to 200 milliseconds. This means that G1 will attempt to schedule
the frequency of GC cycles, as well as the number of zones that are collected in
each cycle, such that each cycle will take approximately 200ms.
    - `InitiatingHeapOccupancyPercent`: This option specifies the percentage of the total heap that may be in use before
G1 will start a collection cycle. The default value is 45. This means that G1 will
not start a collection cycle until after 45% of the heap is in use. This includes both
the new (Eden) and old zone usage in total.

#### Network

- [📺 37. Kafka Performance: Network](https://www.udemy.com/course/kafka-cluster-setup/)
- [Operationalizing ZooKeeper](https://kafka.apache.org/documentation/#zkops)
- **Latency is critical in Kafka.**
- Place Kafka Brokers and Zookeeper as close as possible, ideally within the same region (for cloud setups).
- Avoid placing all components in the same AZ or rack, as it increases the risk of failure, though it may reduce latency.
- Bandwidth is key in Kafka.
- The network can be a bottleneck.
- Ensure sufficient bandwidth to handle multiple connections and TCP requests.
- Guarantee high network performance.
- Monitor the network to identify when it becomes a bottleneck.
- Kernel is not tuned by default for large, high-speed data transfers by default.
- Parameters:
    - Send and receive buffer default size per socket are:
        - net.core.wmem_default and net.core.rmem_default: 131072, 128 KiB
    - Send and receive buffer maximum sizes are:
        - net.core.wmem_max and net.core.rmem_max: 2097152, 2 MiB
    - Send and receive buffer sizes for TCP sockets must be set separately:
        - net.ipv4.tcp_wmem and net.ipv4.tcp_rmem param‐meters. 
        An example setting for each of these parameters is “4096 65536
        2048000,” which is a 4 KiB minimum, 64 KiB default, and 2 MiB maximum buffer.
- Enabling TCP window scaling by setting net.ipv4.tcp_window_scaling to 1: will allow clients
    to transfer data more efficiently, and allow that data to be buffered on the broker side.
- Increasing the value of net.ipv4.tcp_max_syn_backlog above the default of 1024
    will allow a greater number of simultaneous connections to be accepted.
- Increasing
    the value of net.core.netdev_max_backlog to greater than the default of 1000 can
    assist with bursts of network traffic, specifically when using multigigabit network
    connection speeds

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
- **Use XFS**
- XFS also has better performance for Kafka’s workload without
requiring tuning beyond the automatic tuning performed by the filesystem.
- EXT4 -> **XFS (Better option)**
- More efficient when batching disk writes
- Better overall I/O throughput
- Set noatime mount option for the mount point. creation time (ctime), last modified time (mtime), and last access time (atime)
- [📺 Tiered Storage](https://developer.confluent.io/courses/architecture/tiered-storage/)
- Recommended RAID 10 for local storage.

### Number of Nodes
- Determining the number of nodes for a specific cluster is influenced by several factors:
    - How much disk capacity is required for retaining messages?
    - How much storage is available on a single broker?
        e.g. If the cluster is required to retain 10 TB of data and a single broker can store 2 TB, then the minimum cluster size is five brokers. 
        In addition, using replication will increase the storage requirements by at least
        100%, depending on the replication factor chosen. This means that
        this same cluster, configured with replication, now needs to contain at least 10 brokers.
    - Traffic request. 
        - Can that cluster handle all the requests?
        - What is the capacity of the network interfaces?
        - How many consumer do we have?
            - Is the replication needed?
- **Capacity planning** is a critical aspect of designing a Kafka cluster.
    - It is important to understand the expected data volume, the retention period, and the replication factor.
    - It's also important to predict what will be the future data volume and troughput.

### Rack Awareness
- The **best practice** is to have each Kafka broker in a cluster **installed in a different rack**,
or at the very least not share single points of failure for infrastructure services such as
power and network.
- Partition(replica) allocation rack awareness: If the brokers have rack information (available in Kafka release 0.10.0 and higher), Kafka attempts to **assign the replicas for each partition to different racks** whenever possible. This helps ensure that an event causing downtime for an entire rack does not lead to complete unavailability of the partitions.

### Kafka Connect
- **When to use Kafka Connect API or Producer and Consumer API?**
    - Use Kafka clients when you have the ability to modify the application's code that you want to connect to Kafka, and when you intend to either push data into Kafka or pull data from it.
    - You will use **Connect** to link Kafka to datastores that you did not create and whose code you cannot or do not wish to modify.
    - For datastores that already have an existing connector, **Connect** can be utilized by non-developers, who will only need to configure the connectors.
    - If you need to connect Kafka to a datastore and a connector does not currently exist, you can opt to either write an application using the Kafka clients or utilize the Connect API. **Connect** is recommended because it offers out-of-the-box features such as configuration management, offset storage, parallelization, error handling, support for various data types, and standard management REST APIs.
    - Install Connect in a separate cluster from the Kafka cluster to avoid resource contention.
- Components:
    - Connector: A plugin that implements the `SourceConnector` or `SinkConnector` interface.
    - Task: A worker that executes the connector.
    - Worker: A process that manages the connectors and tasks.
        - They are responsible for managing the HTTP and REST interfaces, as well as the configuration, status, and lifecycle of the connectors and tasks.
        - They are responsible for distributing the tasks across the available workers.
        - They are responsible for managing the offsets of the tasks.
- Converters: Converters are used to serialize and deserialize the data between the Kafka Connect framework and the data format of the data source or sink.
- Examples of Source Connector:
    - JDBC Source Connector: It reads data from a relational database and writes it to Kafka.
    - FileStreamSource Connector: It reads data from a file and writes it to Kafka.
    - Debezium: It captures changes in a database and writes them to Kafka.
- Examples of Sink Connector:
    - JDBC Sink Connector: It reads data from Kafka and writes it to a relational database.
    - FileStreamSink Connector: It reads data from Kafka and writes it to a file.
    - Elasticsearch Sink Connector: It reads data from Kafka and writes it to Elasticsearch.
    - S3 Sink Connector: It reads data from Kafka and writes it to Amazon S3.

#### Scalability and High Availability

- [📺 42. Running Kafka in Production on AWS](https://www.udemy.com/course/kafka-cluster-setup/)
    - Separate intances between AZs
    - Use `st1` EBS volumes for best price / performance ratio
    - Mount multiple EBS volumes to the same broker if we need to scale
    - Use `r4.xlarge` or `m4.2xlarge` EBS optimize instances
    - Use DNS names or fixed IP's for the brokers to don't impact the clients.

### Business Continuity / DR
- Mirror maker: It's a build-in Kafka tool to replicate(mirror) data between 2 Kafka clusters.
    - Typically used for Geo Replication between 2 datacenters(e.g.different continents).
    - Based on Kafka Connect framework.
    - Offset translation: It's used to translate the offsets from the source cluster to the destination cluster.
- Redundancy (DR): It can be used to keep a secondary standby cluster just in case the primary cluster fails.
    - Cloud migrations: It can be used to migrate data between on-premises and cloud clusters.
- [Automatic Observer Promotion Brings Fast and Safe Multi-Datacenter Failover with Confluent Platform 6.1](https://www.confluent.io/blog/automatic-observer-promotion-for-safe-multi-datacenter-failover-in-confluent-6-1/)
    - Observer promotion: It's a new feature in Confluent Platform 6.1 that allows a Kafka cluster to automatically promote an observer to a full replica when a broker fails.
        - This feature is useful for multi-datacenter deployments where the observer is in a remote datacenter.
- Cross-datacenter arquitecture: It can be used to replicate data between datacenters.
    - Principals:
        - No less than one cluster in each datacenter.
        - exactly-once delivery semantics
        - Consume from a remote datacenter rathern than produce to it.
            - When replicating datacenters with big distance between them, the latency can be a problem so it's preferred to consume from the remote datacenter rather than produce to it.
- Monitor:
    - Lag: To know if the destination cluster is failing behind the source cluster.
        - The lag is the difference in offsets between the latest message in the source Kafka and the latest message in the destination.
    - Metrics:
        - Consumer:
            - fetch-size-avg
            - fetch-size-max
            - fetch-rate
            - fetch-throttle-time-avg
            - fetch-throttle-time-max
            - io-ratio and io-wait-ratio
        - Producer:
            - batch-size-avg
            - batch-size-max
            - requests-in-flight
            - record-retry-rate
            - io-ratio and io-wait-ratio
    - Create a dedicated process to send an event to a topic in the source cluster and consume it in the destination cluster to check the lag.
- Linux Network tunning:
    - Increase TCP buffer size (net.core.rmem_default, net.core.rmem_max, net.core.wmem_default, net.core.wmem_max, net.core.optmem_max)
    - Enable TCP window scaling (sysctl –w net.ipv4.tcp_window_scaling=1 or add net.ipv4.tcp_window_scaling=1 to /etc/sysctl.conf)
    - Reduce the TCP slow start time (set /proc/sys/net/ipv4/tcp_slow_start_after_idle to 0)

### Data Retention

- Administrator configures a retention period for **each topic**, which specifies either the duration (`log.retention.ms|minutes|hours`) default(`log.retention.hours:168 = 7days`) to store messages before they are deleted or the amount of data(`log.retention.bytes`) to retain before older messages are purged.
- Each partition is split into segments. By default, each segment contains either 1 GB (`log.segment.bytes`) of data or data from one week|7days (`log.retention.hours`), whichever is smaller.
- When a Kafka broker is writing to a partition, if the segment limit is reached (`log.segment.bytes: 1gibibyte`), it closes the current file and begins writing to a new one.

Topic override retention settings:
- `log.retention.ms|minutes|hours` -> `retention.ms` Default is `604800000` (7 days)
- `log.retention.bytes` -> `retention.bytes` Default is `-1` (unlimited)
- `log.segment.bytes` -> `segment.bytes` Default 1073741824 (1GB)
- `log.roll.ms` -> `segment.ms` Default null
