########
#### KAFKA MACHINE
########

# download kafka binaries
cd /home/ec2-user
http://home.apache.org/~rsivaram/kafka-2.0.0-rc3/kafka_2.12-2.0.0.tgz
tar xf kafka_2.12-2.0.0.tgz

# update symlink
ln -sfn /home/ec2-user/kafka_2.12-2.0.0 /home/ec2-user/kafka
ll kafka
# new option in Kafka 2.0.0!
kafka-topics.sh --version


########
#### ADMIN MACHINE
########
# roll restart kafka
kafka-rolling-restart --cluster-type kafka --start-command "systemctl start kafka" --stop-command "systemctl stop kafka" --check-count 2