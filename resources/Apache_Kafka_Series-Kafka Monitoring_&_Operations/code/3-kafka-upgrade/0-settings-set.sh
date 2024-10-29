########
#### KAFKA MACHINE
########

# edit kafka properties
nano kafka.properties
# inter.broker.protocol.version=1.1
# log.message.format.version=1.1


########
#### ADMIN MACHINE
########
# roll restart kafka
kafka-rolling-restart --cluster-type kafka --start-command "systemctl start kafka" --stop-command "systemctl stop kafka" --check-count 2