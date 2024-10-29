### * [1. Apache Kafka Series - Kafka Monitoring & Operations](https://www.udemy.com/course/kafka-monitoring-and-operations)

### Section 5: Kafka Monitoring Setup: Grafana + Prometheus

How to monitor Kafka?

- Administration tools:
    - CMAK Kafka ManagerC: MAK (previously known as Kafka Manager) is a tool for managing Apache Kafka clusters
    - zoonavigator: ZooNavigator is a web-based ZooKeeper UI and editor/browser with many features
- Monitoring tools:
    - https://github.com/linkedin/kafka-monitor: Xinfra Monitor (formerly Kafka Monitor) is a framework to implement and execute long-running kafka system tests in a real cluster.
    - Prometheus
        1. Install the Prometheus JMX agent: https://github.com/prometheus/jmx_exporter on the Brokers and ZooKeeper instances
        2. Install Prometheus tipically on a dedicated instance
        3. Configure Prometheus to add scrape_config job to scrape Kafka prometheus http port
        4. Configure Prometheus to add scrape_config job to scrape Zookeeper prometheus http port
    - Grafana
        1. Install Grafana in a dedicated instance
        2. Configure the prometheus data source on Grafana
        3. Import the Kafka dashboard on Grafana

Important metrics to monitor:
  - Number of active controller: expected 1.
  - Number of under replicated partitions: extected 0.
  - Number of offline partitions: expected 0.
  - Unclean leader election.
  - Brokers online.
  - https://docs.confluent.io/platform/current/kafka/monitoring.html
  - https://kafka.apache.org/documentation/#monitoring