# Domain 3.0 Kafka Security – 15% weight

* [Authentication and Authorization (meanings and methods)](#authentication-and-authorization-meanings-and-methods)
* [In-flight encryption - where and how](#in-flight-encryption---where-and-how)
* [At rest encryption - strategies](#at-rest-encryption---strategies)
* [SSL/TLS keystores and truststores](#ssltls-keystores-and-truststores)
* [Authentication and Authorization troubleshooting](#authentication-and-authorization-troubleshooting)
* [Access Control Lists (ACLs) - where and how used](#access-control-lists-acls---where-and-how-used)
* [Use of wildcards](#use-of-wildcards)

## Authentication and Authorization (meanings and methods)
- [📺 Apache Kafka Series - Kafka Security | SSL SASL Kerberos ACL](https://www.udemy.com/course/apache-kafka-security)
- [Security Overview](https://kafka.apache.org/documentation/#security)

### Authentication SSL
- SSL Encryption ONLY is not equal to autheticated clients.
- SSL Encryption ONLY clients are anonymous. They don't have a specific identiy.
- Authentication refers to 2 ways of certificate checks. (mutualTLS)
- Client and Servers has issued a valid certificate issue from the same CA
- Client and Broker(Server) validate certificates each others
- The client has a valid identity, so we can apply ACL
- Authentication of connections to brokers from clients (producers and consumers), other brokers and tools, using either SSL or SASL

6. [Configuring Kafka Clients](https://kafka.apache.org/documentation/#security_configclients)
    Configure authentication

    - Create the keystore for the client (valid client certificate)
    ```
    $ keytool -keystore client.keystore.jks -alias client-localhost -validity 365 -genkey -keyalg RSA -storetype pkcs12 -storepass clientsecret -dname "CN=client-localhost"

    Generating 3,072 bit RSA key pair and self-signed certificate (SHA384withRSA) with a validity of 365 days
	for: CN=client-localhost
    ```
    - Create the CSR certificate sign request
    ```
    $ keytool -keystore client.keystore.jks -alias client-localhost -certreq -file client-cert-sign-request -storepass clientsecret -keypass clientsecret
    ```
    - Signing the certificate
    ```
      $ openssl x509 -req -CA cacert.pem -CAkey cakey.pem -in client-cert-sign-request -out client-cert-signed -days 365 -CAcreateserial -passin pass:serversecret

        Certificate request self-signature ok
        subject=CN=client-localhost
    ```
    - Import both the client certificate of the CA and the signed certificate into the keystore
    ```
        $ keytool -keystore client.keystore.jks -alias CARoot -import -file cacert.pem -storepass clientsecret -keypass clientsecret
        $ keytool -keystore client.keystore.jks -alias client-localhost -import -file client-cert-signed -storepass clientsecret -keypass clientsecret

        Certificate reply was installed in keystore
    ```
    - Enable in the Brokers, clients needs to be authenticated
      https://kafka.apache.org/documentation/#brokerconfigs_ssl.client.auth

    ```server.properties
        ssl.client.auth=required
    ```
    - Update the client.properties to add the keystore params to enable authentication
    ```
        ssl.keystore.location=client.keystore.jks
        ssl.keystore.password=clientsecret
        ssl.key.password=clientsecret
    ```
    Final config **client.properties** file:
    ```
        security.protocol=SSL
        ssl.truststore.location=client.truststore.jks
        ssl.truststore.password=serversecret
        ssl.keystore.location=client.keystore.jks
        ssl.keystore.password=clientsecret
        ssl.key.password=clientsecret
    ```
    - Test to produce and consume using an authenticate client using SSL certificates
    ```
        $ kafka-console-producer --producer.config client.properties --bootstrap-server localhost:9093 --topic kafka-security-topic
        >New message authenticated
        $ kafka-console-consumer --consumer.config client.properties --bootstrap-server localhost:9093 --topic kafka-security-topic --from-beginning
        Hello
        Test
        New message authenticated
        Processed a total of 3 messages
    ```
    - If we remove the keystore section from the client.properties no more authentication is perform "failed authentication"
    ```
    [2024-11-28 08:39:51,295] ERROR [Consumer clientId=console-consumer, groupId=console-consumer-66244] Connection to node -1 (localhost/127.0.0.1:9093) failed authentication due to: Failed to process post-handshake messages (org.apache.kafka.clients.NetworkClient)
    [2024-11-28 08:39:51,296] WARN [Consumer clientId=console-consumer, groupId=console-consumer-66244] Bootstrap broker localhost:9093 (id: -1 rack: null) disconnected (org.apache.kafka.clients.NetworkClient)
    [2024-11-28 08:39:51,296] ERROR Error processing message, terminating consumer process:  (org.apache.kafka.tools.consumer.ConsoleConsumer)
    org.apache.kafka.common.errors.SslAuthenticationException: Failed to process post-handshake messages
    Caused by: javax.net.ssl.SSLHandshakeException: (bad_certificate) Received fatal alert: bad_certificate
        at java.base/sun.security.ssl.Alert.createSSLException(Alert.java:130)
        at java.base/sun.security.ssl.Alert.createSSLException(Alert.java:117)
        at java.base/sun.security.ssl.TransportContext.fatal(TransportContext.java:365)
        at java.base/sun.security.ssl.Alert$AlertConsumer.consume(Alert.java:287)
        at java.base/sun.security.ssl.TransportContext.dispatch(TransportContext.java:204)
        at java.base/sun.security.ssl.SSLTransport.decode(SSLTransport.java:172)
        at java.base/sun.security.ssl.SSLEngineImpl.decode(SSLEngineImpl.java:736)
        at java.base/sun.security.ssl.SSLEngineImpl.readRecord(SSLEngineImpl.java:691)
        at java.base/sun.security.ssl.SSLEngineImpl.unwrap(SSLEngineImpl.java:506)
        at java.base/sun.security.ssl.SSLEngineImpl.unwrap(SSLEngineImpl.java:482)
        at java.base/javax.net.ssl.SSLEngine.unwrap(SSLEngine.java:679)
        at org.apache.kafka.common.network.SslTransportLayer.read(SslTransportLayer.java:585)
        at org.apache.kafka.common.network.NetworkReceive.readFrom(NetworkReceive.java:84)
        at org.apache.kafka.common.network.KafkaChannel.receive(KafkaChannel.java:462)
        at org.apache.kafka.common.network.KafkaChannel.read(KafkaChannel.java:412)
        at org.apache.kafka.common.network.Selector.attemptRead(Selector.java:678)
        at org.apache.kafka.common.network.Selector.pollSelectionKeys(Selector.java:580)
        at org.apache.kafka.common.network.Selector.poll(Selector.java:485)
        at org.apache.kafka.clients.NetworkClient.poll(NetworkClient.java:595)
        at org.apache.kafka.clients.consumer.internals.ConsumerNetworkClient.poll(ConsumerNetworkClient.java:281)
        at org.apache.kafka.clients.consumer.internals.ConsumerNetworkClient.poll(ConsumerNetworkClient.java:231)
        at org.apache.kafka.clients.consumer.internals.AbstractCoordinator.ensureCoordinatorReady(AbstractCoordinator.java:289)
        at org.apache.kafka.clients.consumer.internals.AbstractCoordinator.ensureCoordinatorReady(AbstractCoordinator.java:263)
        at org.apache.kafka.clients.consumer.internals.ConsumerCoordinator.coordinatorUnknownAndUnreadySync(ConsumerCoordinator.java:450)
        at org.apache.kafka.clients.consumer.internals.ConsumerCoordinator.poll(ConsumerCoordinator.java:482)
        at org.apache.kafka.clients.consumer.internals.LegacyKafkaConsumer.updateAssignmentMetadataIfNeeded(LegacyKafkaConsumer.java:652)
        at org.apache.kafka.clients.consumer.internals.LegacyKafkaConsumer.poll(LegacyKafkaConsumer.java:611)
        at org.apache.kafka.clients.consumer.internals.LegacyKafkaConsumer.poll(LegacyKafkaConsumer.java:591)
        at org.apache.kafka.clients.consumer.KafkaConsumer.poll(KafkaConsumer.java:874)
        at org.apache.kafka.tools.consumer.ConsoleConsumer$ConsumerWrapper.receive(ConsoleConsumer.java:194)
        at org.apache.kafka.tools.consumer.ConsoleConsumer.process(ConsoleConsumer.java:103)
        at org.apache.kafka.tools.consumer.ConsoleConsumer.run(ConsoleConsumer.java:75)
        at org.apache.kafka.tools.consumer.ConsoleConsumer.main(ConsoleConsumer.java:57)
    Processed a total of 0 messages
    ```

### Authentication SASL
- [Authentication using SASL](https://kafka.apache.org/documentation/#security_sasl)
- [Simple Authentication and Security Layer](https://en.wikipedia.org/wiki/Simple_Authentication_and_Security_Layer)
- SASL is combined with SSL/TLS for encryption in transit
- [course: Apache Kafka® Security Kafka Authentication with SSL and SASL_SSL](https://developer.confluent.io/courses/security/authentication-ssl-and-sasl-ssl/)
- SASL_SSL Broker example:
    ```
    listeners=SASL_SSL://host.name:port # Listener for clients using SASL_SSL
    security.inter.broker.protocol=SASL_SSL # Broker to Broker communication using SASL_SSL. Valid values are: PLAINTEXT, SSL, SASL_PLAINTEXT, SASL_SSL
    sasl.mechanism.inter.broker.protocol=PLAIN # SASL mechanism used for inter-broker communication. Default is GSSAPI.
    sasl.enabled.mechanisms=PLAIN # The list of SASL mechanisms enabled in the Kafka server
    ```

### Authorization
- Authorization of read / write operations by clients

## In-flight encryption - where and how

- [📺 Apache Kafka Series - Kafka Security | SSL SASL Kerberos ACL - SSL in Kafka](https://www.udemy.com/course/apache-kafka-security)
- [Encryption and Authentication using SSL](https://kafka.apache.org/documentation/#security_ssl)
- It means for encription in transit, to encrypt any data transmitted from and to the Brokers
- SSL also can be used for authentication, not only encryption in transit.

### Server: SSL Brokers

1. [Generate SSL key and certificate for each Kafka broker](https://kafka.apache.org/documentation/#security_ssl_key)

    Kafka expects all keys and certificates to be stored in keystores

    `keytool -keystore server.keystore.jks -alias localhost -validity 365 -genkey -keyalg RSA -storetype pkcs12 -storepass serversecret -dbname "CN=localhost"`

    - Check the content of the keystore `keytool -list -v -keystore server.keystore.jks`

2. [Create our own CA](https://kafka.apache.org/documentation/#security_ssl_ca)

    `openssl req -x509 -config openssl-ca.cnf -newkey rsa:4096 -sha256 -nodes -out cacert.pem -outform PEM`

    - The next step is to add the generated CA to the **clients' truststore** so that the clients can trust this CA:

        `keytool -keystore client.truststore.jks -alias CARoot -import -file cacert.pem`
    - Provide a truststore for the Kafka brokers as well and it should have all the CA certificates that clients' keys were signed by.

        `keytool -keystore server.truststore.jks -alias CARoot -import -file cacert.pem`

3. Signing the certificate

    - `keytool -keystore server.keystore.jks -alias localhost -certreq -file cert-file`
    - `openssl x509 -req -CA cacert.pem -CAkey cakey.pem -in cert-file -out cert-signed -days 365 -CAcreateserial -passin pass:serversecret`

    Import both the certificate of the CA and the signed certificate into the keystore

    - `keytool -keystore server.keystore.jks -alias CARoot -import -file cacert.pem`
    - `keytool -keystore server.keystore.jks -alias localhost -import -file cert-signed`

4. [Configuring Kafka Brokers](https://kafka.apache.org/documentation/#security_configbroker)

    - Update the server.properties on the Kafka Broker
    ```
    listeners=PLAINTEXT://:9092,SSL://0.0.0.0:9093

    # Listener name, hostname and port the broker will advertise to clients.
    # If not set, it uses the value for "listeners".
    advertised.listeners=PLAINTEXT://localhost:9092,SSL://localhost:9093

    ssl.keystore.location=server.keystore.jks
    ssl.keystore.password=serversecret
    ssl.key.password=serversecret
    ssl.truststore.location=server.truststore.jks
    ssl.truststore.password=serversecret

    ssl.client.auth=required
    ```

    - Restart Kafka service
    - Check the SSL connection `openssl s_client -connect localhost:9093`

### Client: SSL

6. [Configuring Kafka Clients](https://kafka.apache.org/documentation/#security_configclients)
    - Be sure that we imported the CA in the trustore in order to trust any cert issued by our CA
    `keytool -keystore client.truststore.jks -alias CARoot -import -file cacert.pem`
    - Check the it's imported properly.
    `keytool -list -v -keystore client.truststore.jks`
    - Configure client properties

    ```client.properties
    security.protocol=SSL
    ssl.truststore.location=client.truststore.jks
    ssl.truststore.password=serversecret
    ```
    - let's create a new topic using client certificates, SSL encryption in transit, SSL Port 9093
    ```
        $ kafka-topics --command-config client.properties --bootstrap-server localhost:9093 --create --topic kafka-security-topic
        Created topic kafka-security-topic.
    ```
    - Let's produce a new message
    `kafka-console-producer --producer.config client.properties --bootstrap-server localhost:9093 --topic kafka-security-topic`
    - Let's consume the message
    ```
        $ kafka-console-consumer --consumer.config client.properties --bootstrap-server localhost:9093 --topic kafka-security-topic --from-beginning
        Hello
        Test
    ```

## SSL/TLS keystores and truststores
- Keystore
    - Kafka expects all keys and certificates to be stored in keystores
    - Brokers may be configured with SSL keystores with short validity periods to reduce the risk of compromised certificates.
    - Keystores may be updated dynamically without restarting the broker
- Truststore
    - Kafka clients must trust the CA that signed the broker's certificate
    - Clients must have the CA certificate in their truststore
    - Brokers must have the CA certificate in their truststore

## At rest encryption - strategies
- https://developer.confluent.io/courses/security/encryption/
- Producer: Encrypt the message before to publish to the broker
    - Consumer: Decrypt the message
- Broker: Underline OS encryption
    - Disk/Volume encryption

## Access Control Lists (ACLs) - where and how used

- Once client are authenticated using SSL or SASL, now it's time to define permissions. ACL's
- ACLS Operations `--operation`:
    - Read
    - Write
    - Create
    - Delete
    - Alter
    - Describe
    - ClusterAction
    - DescribeConfigs
    - AlterConfigs
    - IdempotentWrite
    - CreateTokens
    - DescribeTokens
    - All
- Permissions applied to [Resources in Kafka](https://kafka.apache.org/documentation/#resources_in_kafka): 
    - **Topics**: which client can read/write
    - **Consumer** groups: which client can use it
    - **Cluster**: which client can delete or apply settings
    - **TransactionalId**: which client can produce transactional messages
    - **DelegationToken**: this represents the delegation tokens in the cluster.
    - **Users**: CreateToken and DescribeToken operations can be granted to User resources to allow creating and describing tokens for other users.
- **Super users**: It can do all without any ACL

### where
- ACL's are stored in Zookeeper, as many other entities.
- Zookeeper should be securize ,in order to prevent that nobody else than Admins can access to it. 
    - Only Kafka Admins should have permissions to create topics and ACLs.
- **How to enable ACL's on Kafka brokers?**
    - [Authorization and ACLs](https://kafka.apache.org/documentation/#security_authz)
    ```server.properties
    # server.properties
    authorizer.class.name=kafka.security.authorizer.AclAuthorizer
    allow.everyone.if.no.acl.found=false
    super.users=User:admin;User:Alice
    ```
    - **Add a kafka-acl to consume from a topic**: `kafka-acls --bootstrap-server localhost:9092 --add --allow-principal User:CN=client-localhost --allow-host 127.0.0.1 --operation Read --operation Write --operation Describe --topic kafka-security-topic`
    - **List the current ACLs for a specific topic**

    ```bash
        $ kafka-acls --bootstrap-server localhost:9092 --list --topic kafka-security-topic
    Current ACLs for resource `ResourcePattern(resourceType=TOPIC, name=kafka-security-topic, patternType=LITERAL)`:
        (principal=User:CN=client-localhost, host=127.0.0.1, operation=WRITE, permissionType=ALLOW)
        (principal=User:CN=client-localhost, host=127.0.0.1, operation=DESCRIBE, permissionType=ALLOW)
        (principal=User:CN=client-localhost, host=127.0.0.1, operation=READ, permissionType=ALLOW)
    ```
#### Kafka ACLs kafka-acls command
- `kafka-acls.sh`: Kafka ACLs command line tool

## Authentication and Authorization troubleshooting

### Authorization
- `kafka/config/log4j.properties`: Configure Kafka logs
- `kafka/logs/kafka-authorizer.log`: Audit security logs

## Use of wildcards

## Security recommendations (Checklist)
- Education and training for the users
- Use of SSL/TLS for encryption in transit
- Use of SASL OR SSL for authentication
- Certificate dynamic rotation strategy
- Use of ACLs for authorization
- Use of disk encryption for at rest encryption
- Protect Zookeeper
    - Only Kafka Admins should have permissions to create topics and ACLs.
    - Zookeeper network isolation between brokers
- Use of secure brokers
    - Enable SSL for brokers inter broker communication
- Use of secure clients
    - Robust decomissioning of old clients
    - Enable reauthentication `connections.max.reauth.ms` https://kafka.apache.org/documentation#brokerconfigs_connections.max.reauth.ms
- Use of secure tools
- Setup Audit logs
- Regularly review and update security settings
