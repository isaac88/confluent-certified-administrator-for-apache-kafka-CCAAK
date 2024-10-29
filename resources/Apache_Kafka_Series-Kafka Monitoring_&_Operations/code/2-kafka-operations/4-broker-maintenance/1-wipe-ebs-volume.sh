########
#### KAFKA MACHINE
########

# make sure all the topics have a RF of at least 2!!!

# stop Kafka
sudo systemctl stop kafka

# delete Kafka data
rm -r -f /data/kafka/*

# data is removed indeed
cd data 
du -sh kafka/

# stop Kafka
sudo systemctl start kafka
du -sh kafka/

# data has been recovered and replicated
