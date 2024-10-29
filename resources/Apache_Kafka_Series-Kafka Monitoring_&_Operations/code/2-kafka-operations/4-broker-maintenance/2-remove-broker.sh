########
#### ADMIN MACHINE
########

export ZK_HOST="172.31.9.21:2181"

# Documentation: https://github.com/linkedin/kafka-tools/wiki/module-remove

# Remove broker 4
kafka-assigner -z $ZK_HOST -g remove -b 4

# Execute 
kafka-assigner -z $ZK_HOST -e remove -b 4