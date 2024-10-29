### * [2. Apache Kafka Series - Kafka Cluster Setup & Administration ](https://www.udemy.com/course/kafka-cluster-setup/)

#### Zookepeer
- What is Zookeeper?
    - What are the main features?
        - Distributed configuration management.
        - Self election / consensus building
        - Coordination and locks
        - Key value store
    - What is the role of Zookeeper in Kafka?
        - Brokers registration + heartbeats
        - Topics configurations: partitions, replication factor, etc.
        - List of ISR, In Sync Replicas
        - Leader election, voting mechanissim.
        - Store the Kafka cluster id.
        - Store ACL
        - Quotas configurations if it's enabled
    - Quorum

#### Zookeeper practise hands-on
- Understand the main and key Zookeeper settings

    ```
    tickTime=2000
    dataDir=/var/lib/zookeeper/
    clientPort=2181
    initLimit=5
    syncLimit=2
    server.1=zoo1:2888:3888
    server.2=zoo2:2888:3888
    server.3=zoo3:2888:3888
    ```

- Undestand why it's recommended to disable SWAP `vm.swappiness` (Disabling SWAP for Optimal Performance)
- Configure Zookeeper in distribute way to understand the quorum
    - Testing Quorum Behavior:
        - Introduce failures or "chaos" in the cluster (e.g., stop or isolate a node).
        - Observe how the cluster responds and recovers.
        - This helps in understanding Zookeeper's fault tolerance and leader election mechanisms.
- Use `zookeeper-shell localhost:2181` to create metadata entities
    - The zookeeper-shell is a command-line tool to interact with the Zookeeper service. Use it to create, update, or delete metadata entities.
    - Understand how this entities are replicated inside the Zookeeper cluster
- Understand what are the main Zookeeper commands for monitoring porpuse

### Kafka Cluster setup

- Recap the Kafka basics learn in the previous course before to move on
- Understand the Kafka broker sizing
    - How big should be my cluster?
- Undertand the key configuration settings
