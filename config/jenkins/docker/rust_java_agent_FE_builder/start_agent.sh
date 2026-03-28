#!/bin/bash
source .token

#java -jar agent.jar -jnlpUrl http://helios.greece.local:8090/manage/computer/test/slave-agent.jnlp -secret 70aa42c50f60c84d90eb5c17b1bfee836a3590fbc4b839e0202222f20209a36e
#curl -sO http://helios.greece.local:8090/jnlpJars/agent.jar
java -jar agent.jar -jnlpUrl http://helios.greece.local:8090/manage/computer/rust_java_frontend_node/slave-agent.jnlp -secret ${SECRET}
