# DEVPAAS with VMs
Scope of this project is create a developer paas (a platform for development) with all the components needed to developm a
* Java project
* Android project
* Python project
* npm project

![Alt text](http://g.gravizo.com/g?
@startuml;
title devpaas vm architecture;
node nginx <<vm>> as nginx;
node gitlab <<vm>> as scm;
node agilfant <<vm>> as pms;
node sonarqube <<vm>> as qms;
node jenkins <<vm>> as cis;
node nexus <<vm>> as rms;
node elastic <<vm>> as elastic;
node logspout <<vm>> as logspout;
node kibana <<vm>> as kibana;
database mariadb_gitlab <<vm>>;
database mariadb_sonarqube <<vm>>;
nginx -left-> pms : "http 80";
nginx -down-> scm : "/gitlab http 80";
scm -down-> mariadb_gitlab : tcp 3306;
nginx -down-> cis : "/jenkins http 8080" ;
nginx -down-> qms : "/sonarqube http 9000" ;
qms -down-> mariadb_sonarqube;
nginx -right-> rms: "/nexus http 8081";
nginx --> logspout;
nginx --> kibana;
kibana --> elastic;
pms --> logspout;
cis --> scm : http 80;
cis --> qms : http 9000;
cis --> rms : http 8081;
cis --> logspout;
scm --> logspout;
qms --> logspout;
rms --> logspout;
mariadb_gitlab --> logspout;
mariadb_sonarqube --> logspout;
logspout -right-> elastic;
@enduml
)
