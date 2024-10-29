########
#### ADMIN MACHINE
########

cd 
wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.2.1.linux-amd64.tar.gz 
tar -zxvf grafana-*.gz 
rm grafana-*.gz 
mv grafana-*/ grafana
cd grafana 

# enable anonymous authentication by setting
vi conf/defaults.ini
# you can type "/anonymous" to jump the right line
# Insert following Content:
# [auth.anonymous]
# enabled = true
# org_name = Main Org.
# org_role = Admin

# Start grafana:
bin/grafana-server

# Setup as SystemD service:
sudo nano /etc/systemd/system/grafana.service

# imports dashboards:
# https://grafana.com/dashboards/721
# https://grafana.com/dashboards/5468
# https://grafana.com/dashboards/762
