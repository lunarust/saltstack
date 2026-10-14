#!/bin/bash

docker build -t 192.168.1.216:5000/jenkins_java_rust_agent .
docker push 192.168.1.216:5000/jenkins_java_rust_agent
