#!/bin/bash -eux
export SONARQUBE_HOME=/var/lib/sonarqube

echo "***** Sonar user creation *****"
sudo adduser --no-create-home --disabled-login --disabled-password --gecos "" sonar

sudo apt-get -y install unzip

cp /tmp/sonarqube/resources/.my.cnf ~/

echo "***** Configure mysql for sonarqube db *****"
mysql -h "localhost" < /tmp/sonarqube/resources/sonarqube.sql

echo "***** Download sonarqube *****"
mkdir $HOME/sonarqube/
wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-6.5.zip \
  -O $HOME/sonarqube/sonarqube-6.5.zip

sudo mkdir $SONARQUBE_HOME
sudo cp $HOME/sonarqube/sonarqube-6.5.zip /var/lib/sonarqube
cd $SONARQUBE_HOME

echo "***** Extract Sonarqube *****"
sudo unzip sonarqube-6.5.zip

sudo ln -s sonarqube-6.5 sonar

sudo cp /tmp/sonarqube/resources/sonar.properties $SONARQUBE_HOME/sonar/conf

sudo chown -R sonar:sonar $SONARQUBE_HOME

echo '****** Sonarqube Service Configuration ******'
sudo cp /tmp/sonarqube/resources/sonarqube.service        /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable sonarqube.service
sudo systemctl start sonarqube.service


echo '****** Sonarqube Plugin Installation ******'

echo '****** Stop Sonarqube service ******'
sudo systemctl stop sonarqube.service

cd /tmp/sonarqube/plugins

echo '****** Restart Sonarqube service ******'
sudo systemctl start sonarqube.service