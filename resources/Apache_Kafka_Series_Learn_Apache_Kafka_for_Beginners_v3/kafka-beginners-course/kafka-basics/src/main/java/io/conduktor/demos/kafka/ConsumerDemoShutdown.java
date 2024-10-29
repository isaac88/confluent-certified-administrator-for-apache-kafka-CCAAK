package io.conduktor.demos.kafka;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.CooperativeStickyAssignor;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.common.errors.WakeupException;
import org.apache.kafka.common.serialization.StringDeserializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.Duration;
import java.util.Arrays;
import java.util.Properties;

public class ConsumerDemoShutdown {

    private static final Logger log = LoggerFactory.getLogger(ConsumerDemoShutdown.class.getSimpleName());
    public static void main(String[] args) {
        log.info("I'm a Kafka Consumer!");

        String groupId = "my-java-consumer";

        // Create a producer properties
        Properties properties = new Properties();
        // https://kafka.apache.org/documentation/#producerconfigs_bootstrap.servers
        properties.setProperty("bootstrap.servers", "localhost:9092");

        // create consumer configs
        // We need to know the format of the data in the topic in order to deserialize it
        properties.setProperty("key.deserializer", StringDeserializer.class.getName());
        properties.setProperty("value.deserializer", StringDeserializer.class.getName());

        properties.setProperty("group.id", groupId);
        properties.setProperty("auto.offset.reset", "earliest");

        // set consumer properties group assignment cooperative in order to control the rebalancing
        properties.setProperty("partition.assignment.strategy", CooperativeStickyAssignor.class.getName());

        // Create a consumer
        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(properties);

        // get a reference to the main thread
        final Thread mainThread = Thread.currentThread();

        // Adding a shutdown hook
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            log.info("Caught shutdown hook");
            log.info("Closing consumer");
            consumer.wakeup();
            // join the main thread to allow the execution of the code in the main thread
            try {
                mainThread.join();
            } catch (WakeupException e) {
                log.error("Got WakeupException", e);
            }
            catch (InterruptedException e) {
                e.printStackTrace();
            } finally {
                consumer.close(); // close the consumer, it'll commit the offsets
                log.info("The consumer now is gracefully shutdown");
            }
        }));

        try {
            // subscribe consumer to our topic(s)
            consumer.subscribe(Arrays.asList("first_topic"));

            // poll for new data
            while (true) {
                // log.info("Polling for new data");
                ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(1000));

                for (ConsumerRecord<String, String> record : records) {
                   // log.info("Key: " + record.key() + " | Value: " + record.value());
                    log.info("Partition: " + record.partition() + " | Offset: " + record.offset());
                }
            }
        } catch (Exception e) {
            log.error("Error while consuming", e);
        }

    }
}
