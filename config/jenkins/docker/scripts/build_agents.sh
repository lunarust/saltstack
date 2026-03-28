docker build -t 192.168.1.217:5000/jenkins_ssh_agent .

# Java agent
curl -sO http://helios.greece.local:8090/jnlpJars/agent.jar


docker build -t 192.168.1.217:5000/jenkins_java_rust_agent_frontend .



docker build -t 192.168.1.217:5000/jenkins_java_rust_agent .
