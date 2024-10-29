package io.conduktor.demos.kafka.wikimedia;

import com.launchdarkly.eventsource.EventHandler;
import com.launchdarkly.eventsource.MessageEvent;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class WikimediaChangeHandler implements EventHandler {

    KafkaProducer<String, String> kafkaProducer;
    String topic;
    private final Logger log = LoggerFactory.getLogger(WikimediaChangeHandler.class.getSimpleName());

    //  Create a public constructor that takes a KafkaProducer and a String as arguments
    //  and assigns them to the kafkaProducer and topic fields, respectively.
    public WikimediaChangeHandler(KafkaProducer<String, String> kafkaProducer, String topic){
        this.kafkaProducer = kafkaProducer;
        this.topic = topic;
    }


    @Override
    public void onOpen() throws Exception {
    // nothing here
    }

    @Override
    public void onClosed() throws Exception {
        kafkaProducer.close();
    }

    @Override
    public void onMessage(String s, MessageEvent messageEvent) throws Exception {
        log.info(messageEvent.getData());
        // asyncronous
        kafkaProducer.send(new ProducerRecord<>(topic, messageEvent.getData()));
    }

    @Override
    public void onComment(String s) {
        // nothing here
    }

    @Override
    public void onError(Throwable throwable) {
        log.error("Error in Stream Reading", throwable);
    }
}
