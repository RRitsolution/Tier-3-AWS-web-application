#!/bin/bash

#echo 'Configure Front-end Server'

set -e

scp index.html ubuntu@10.0.154.158:/home/ubuntu
scp 000-default.conf ubuntu@10.0.154.158:/home/ubuntu
ssh ubuntu@10.0.154.158 << 'EOF'

sudo apt update -y
sudo apt upgrade -y
sudo apt install apache2 -y
sudo chmod 644 index.html
sudo chmod 644 000-default.conf
sudo mv index.html /var/www/html/
sudo mv 000-default.conf /etc/apache2/sites-available/ 
sudo systemctl start apache2
sudo systemctl restart apache2

echo "Front end server configured"

EOF





echo 'Configure Back-end Server'

scp ./app.py ubuntu@10.0.152.214:/home/ubuntu
ssh ubuntu@10.0.152.214 << 'EOF'

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y python3 python3-pip python3-flask python3-pymysql
chmod 700 app.py
nohup python3 app.py > app.log 2>&1 &

echo 'Configured Back-end  Server'

EOF




#echo 'Configure database server'

#ssh ubuntu@10.0.134.199 << 'EOF'

#sudo apt update -y
#sudo apt upgrade -y
#sudo apt install mysql-server -y
#sudo systemctl start mysql
#sudo systemctl enable mysql

#echo 'Configured database server'
#EOF
