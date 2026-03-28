#!/bin/bash

docker build -t 192.168.1.217:5000/jenkins_java_rust_agent_frontend .
docker push 192.168.1.217:5000/jenkins_java_rust_agent_frontend
