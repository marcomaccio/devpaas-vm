#!/bin/bash -e

echo "***** JENKINS installation"
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get -y update
sudo apt-get install -y jenkins

echo '****** Installing Jenkins Plugins'
cd /tmp/jenkins/scripts
sudo chmod +x install-jenkins-plugins.sh
sudo ./install-jenkins-plugins.sh plugins.txt
echo 'Installing Jenkins Plugins --> SUCCESS'

echo '****** Stop Jenkins Service ******'
sudo service jenkins stop

echo '****** Moving Jenkins Configuration files ******'
#sudo cp /tmp/jenkins/configs/etc-default-jenkins.conf                                     /etc/default/jenkins
sudo cp /tmp/jenkins/configs/config.xml                                                   /var/lib/jenkins/
sudo cp /tmp/jenkins/configs/hudson.tools.JDKInstaller.xml                                /var/lib/jenkins/
sudo cp /tmp/jenkins/configs/hudson.tasks.Ant.xml                                         /var/lib/jenkins/
sudo cp /tmp/jenkins/configs/hudson.tasks.Maven.xml                                       /var/lib/jenkins/
sudo cp /tmp/jenkins/configs/hudson.plugins.git.GitTool.xml                               /var/lib/jenkins/
sudo cp /tmp/jenkins/configs/hudson.plugins.gradle.Gradle.xml                             /var/lib/jenkins/
sudo cp /tmp/jenkins/configs/hudson.plugins.groovy.Groovy.xml                             /var/lib/jenkins/

sudo cp /tmp/jenkins/configs/biz.neustar.jenkins.plugins.packer.PackerPublisher.xml       /var/lib/jenkins/
sudo cp /tmp/jenkins/configs/org.jenkinsci.plugins.terraform.TerraformBuildWrapper.xml    /var/lib/jenkins/

echo '****** Setting up Jenkins admin users'
cd /var/lib/jenkins
sudo mkdir -p users/admin
sudo cp /tmp/jenkins/configs/admin-config.xml /var/lib/jenkins/users/admin/config.xml

echo '****** Changing the permissions for those file that has been moved'
cd /var/lib/
sudo chown -R jenkins:jenkins /var/lib/jenkins

echo '****** Start Jenkins Service'
sudo service jenkins start