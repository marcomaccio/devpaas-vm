# DEVPAAS with VMs
Scope of this project is to create a developer paas (Platform As A Service for development) with all the needed components to develop:
* Java project
* Android project
* Python project
* npm project

![Alt text](http://g.gravizo.com/g?
@startuml;
title Dev PAAS vm architecture;
node nginx <<vm>> as nginx;
node gitlab <<vm>> as scm;
node agilfant <<vm>> as pms;
node sonarqube <<vm>> as qms;
node jenkins <<vm>> as cis;
node nexus <<vm>> as rms;
node elastic <<vm>> as elastic;
node logspout <<vm>> as logspout;
node kibana <<vm>> as kibana;
database mariadb_agilefant <<vm>>;
database mariadb_gitlab <<vm>>;
database mariadb_sonarqube <<vm>>;
nginx -left-> pms : "http 80";
pms -down-> mariadb_agilefant : tcp 3306;
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
mariadb_agilefant --> logspout;
logspout -right-> elastic;
@enduml
)

![Alt text](http://g.gravizo.com/g?
@startuml;
title Dev PAAS Users;
actor :Customer:      as customer;
actor :Product Owner: as po;
actor :Scrum Master:  as sm;
actor :Developer:     as dev;
User <|-- po;
User <|-- sm;
User <|-- dev;
User <|-- customer;
@enduml)
