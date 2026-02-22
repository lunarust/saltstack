sudo docker build -t rustmeup -f Dockerfile .

curl -O http://jenkins-sandbox:8080/jnlpJars/agent.jar

java -jar agent.jar -url http://jenkins-sandbox:8080/ -secret ${SECRET} -name "jenkins_sandbox_rustagent" -webSocket -workDir "/opt/rust"


git config --global --add safe.directory /opt/jenkins/rust_home/Wobbles_hazards/Build
