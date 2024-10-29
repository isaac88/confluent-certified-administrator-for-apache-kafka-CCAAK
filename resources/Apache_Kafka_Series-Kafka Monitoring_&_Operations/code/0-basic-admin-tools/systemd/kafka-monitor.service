# /etc/systemd/system/kafka-monitor.service
[Unit]
Description=Kafka Monitor
After=network.target

[Service]
User=ec2-user
Group=ec2-user
WorkingDirectory=/home/ec2-user/kafka-monitor
ExecStart=/home/ec2-user/kafka-monitor/bin/kafka-monitor-start.sh /home/ec2-user/kafka-monitor/config/kafka-monitor.properties
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target