CREATE DATABASE sonardb CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'sonaradmin' IDENTIFIED BY 'sonar123!';
GRANT ALL ON sonardb.* TO 'sonaradmin'@'%' IDENTIFIED BY 'sonar123!';
GRANT ALL ON sonardb.* TO 'sonaradmin'@'localhost' IDENTIFIED BY 'sonar123!';
FLUSH PRIVILEGES;
