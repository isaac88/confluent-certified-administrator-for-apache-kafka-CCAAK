########
#### KAFKA MACHINES
########

# update kafka.properties with a config:
echo "min.insync.replicas=2" >> /home/ec2-user/kafka.properties

########
#### ADMIN MACHINE
########
# roll restart kafka
kafka-rolling-restart --cluster-type kafka --start-command "systemctl start kafka" --stop-command "systemctl stop kafka" --check-count 3