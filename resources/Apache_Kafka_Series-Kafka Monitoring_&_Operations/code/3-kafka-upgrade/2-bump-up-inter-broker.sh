########
#### KAFKA MACHINE
########

# edit kafka properties, change inter.broker.protocol.version
nano kafka.properties
# inter.broker.protocol.version=2.0
# log.message.format.version=1.1


########
#### ADMIN MACHINE
########
# roll restart kafka
kafka-rolling-restart --cluster-type kafka --start-command "systemctl start kafka" --stop-command "systemctl stop kafka" --check-count 2