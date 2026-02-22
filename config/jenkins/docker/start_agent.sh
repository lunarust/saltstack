#!/bin/bash
source .token
java -jar agent.jar -url http://jenkins-sandbox:8080/ -secret ${SECRET} -name "jenkins_sandbox_rustagent" -webSocket -workDir "/opt/rust"
