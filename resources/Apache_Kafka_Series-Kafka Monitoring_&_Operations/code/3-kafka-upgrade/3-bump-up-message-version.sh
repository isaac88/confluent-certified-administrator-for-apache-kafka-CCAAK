### CONSUMER / PRODUCERS ####
### UPGRADE CLIENT IS THERE'S A NEW MESSAGE FORMAT FIRST ####

########
#### KAFKA MACHINE
########

# edit kafka properties, edit log.message.format.version
nano kafka.properties
# inter.broker.protocol.version=2.0
# log.message.format.version=2.0


########
#### ADMIN MACHINE
########
# roll restart kafka
kafka-rolling-restart --cluster-type kafka --start-command "systemctl start kafka" --stop-command "systemctl stop kafka" --check-count 2


########
#### KAFKA MACHINE
########

# optional: remove kafka 1.1.1 binaries
rm -r -f kafka_2.12-1.1.1/