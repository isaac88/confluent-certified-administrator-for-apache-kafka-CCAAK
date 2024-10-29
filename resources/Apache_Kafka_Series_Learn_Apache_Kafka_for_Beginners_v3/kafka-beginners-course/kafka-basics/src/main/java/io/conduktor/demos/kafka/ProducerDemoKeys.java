package io.conduktor.demos.kafka;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.StringSerializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Properties;

public class ProducerDemoKeys {

    private static final Logger log = LoggerFactory.getLogger(ProducerDemoKeys.class.getSimpleName());
    public static void main(String[] args) throws InterruptedException {
        log.info("Hello and welcome callback test!");

        // Create a producer properties
        Properties properties = new Properties();
        // https://kafka.apache.org/documentation/#producerconfigs_bootstrap.servers
        properties.setProperty("bootstrap.servers", "localhost:9092");

        properties.setProperty("key.serializer", StringSerializer.class.getName());
        properties.setProperty("value.serializer", StringSerializer.class.getName());

        // Create a producerProducerDemoWithCallBack
        KafkaProducer<String, String> producer = new KafkaProducer<>(properties);

        for (int j = 0; j < 2; j++) {
            // In order to send the same key to the same partition, we need to send the same key
            for (int i = 0; i < 10; i++) {

                String topic = "first_topic";
                String value = "hello world with keys " + i;
                String key = "id_" + i;

                // Create a producer record
                ProducerRecord<String, String> record = new ProducerRecord<>(topic, key, value);

                // send data
                producer.send(record, (recordMetadata, e) -> {
                    // executes every time a record is successfully sent or an exception is thrown
                    if (e == null) {
                        // the record was successfully sent
                        log.info("Key: " + key + " | Partition: " + recordMetadata.partition() + "\n");
                    } else {
                        log.error("Error while producing", e);
                    }
                });
            }

            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        // flush and close producer
        // tell the producer to send all the data and block until it's done syncronously
        producer.flush();

        // flush and close producer
        producer.close();
    }
}
