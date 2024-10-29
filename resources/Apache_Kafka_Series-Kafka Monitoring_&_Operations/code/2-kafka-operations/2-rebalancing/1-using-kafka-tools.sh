########
#### ADMIN MACHINE
########

export ZK_HOST="172.31.9.21:2181"
export KAFKA_HOST="172.31.33.33:9092"

# install Kafka tools
sudo yum install -y gcc-c++ 
pip install --user kafka-tools

# check the command is working
kafka-assigner

# ensure the kafka commands are in .bash_profile
cat << "EOF" >> /home/ec2-user/.bash_profile
DAEMON_PATH=/home/ec2-user/kafka/bin
export PATH=$PATH:$DAEMON_PATH
export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"
export JAVA_HOME="/usr/lib/jvm/jre-1.8.0-openjdk"
EOF
source /home/ec2-user/.bash_profile

# documentation is here: https://github.com/linkedin/kafka-tools/wiki/Kafka-Assigner

# test an assigner
kafka-assigner  -z $ZK_HOST --generate balance --types count
# execute an assignment
kafka-assigner  -z $ZK_HOST -e balance --types count
# Documentation for balance module: https://github.com/linkedin/kafka-tools/wiki/module-balance
