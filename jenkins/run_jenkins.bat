@echo off
set JENKINS_HOME=C:\Jenkins\home
java -jar "%~dp0jenkins.war" --httpPort=8080
