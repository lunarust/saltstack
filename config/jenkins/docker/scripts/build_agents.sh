docker build -t 192.168.1.217:5000/jenkins_ssh_agent .


docker run -d --rm --name=agent1 -p 22022:22 \
-e "JENKINS_AGENT_SSH_PUBKEY=ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDLhxpFpdVjDgeK+LHmm/Af3U+DB+02PUpj6ffejYDiQCol9k4IalMER4twCIR2ZEZmB/t/Jx0+HdRo4mqJycCrqdXmzw8I5X1p2rvqIoTgwmuEbHuwXs45Xtn/d+s2MrugKLg1WNlOR0ye2nYcx6OXj7gxbwclNIdSfBi4xh9PUclanrMtZkVsR3b8SATG432Z9jrBc+1Nil9lmzL0iOfG/xpOl1ey0hXumhj1chhw/ycVDLPBfzdAzJgxkNjs8GA9mn6vAQTE9ZbbcB5ZDPhKnJn2OIEElV4og1mTGIAkU6Ka2JwYIsVQWL0gl8gGpXnxBmW6OGYZhDICBP6mkv4sTYD6ibsRImKhaks8QdwAM5ci+GGEecnKqElK11j5KNjbbQHbmnZm356ePPmlFzHlKUnJApEy/GlFxtldgGoMJtFhsXnHPrEAjYU2LDox5Q3QZpLdXhG2rFFQGPHyDJxM0zWGHear+DoUNm9ylClvadmUsOdVtkH2SaT/ZLclAbub8DkjCESGoW62JLk7M4MwvRAjQYVfLPG7Jn6msbV4FZ5TEjzsbB+PIaNsmukn30MCugXWG9kuYtJLUyYxwOA2DKaMlFp0Kekm4GHOAAfdu5Z8PNtMO4NPBxcVpNTaQ9qJrVEe5FMd2hIBML0c1puJ8hOwxuQrlkujzagITrASiQ==" \
192.168.1.217:5000/jenkins_ssh_agent


# Java agent
curl -sO http://helios.greece.local:8090/jnlpJars/agent.jar


docker build -t 192.168.1.217:5000/jenkins_java_rust_agent_frontend .



docker build -t 192.168.1.217:5000/jenkins_java_rust_agent .
