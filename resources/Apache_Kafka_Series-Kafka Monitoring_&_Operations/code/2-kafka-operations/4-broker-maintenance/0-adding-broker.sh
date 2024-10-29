########
#### ADMIN MACHINE
########

export ZK_HOST="172.31.9.21:2181"

# Documentation for balance module: https://github.com/linkedin/kafka-tools/wiki/module-balance
# generate an assignment that includes broker 4
kafka-assigner  -z $ZK_HOST --generate balance --types even
# execute the assignment
kafka-assigner  -z $ZK_HOST -e balance --types even

# watch results in Kafka Manager
