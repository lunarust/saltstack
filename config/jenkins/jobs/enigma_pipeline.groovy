import groovy.json.*

node() {
  milestone 1
  stage('Backend') {
    def userInput = input(
        id: 'userInput', message: 'Should we build the Backend?', parameters: [
        [$class: 'ChoiceParameterDefinition', choices: 'YES\nNO', description: 'Build Backend?', name: 'be_build']
    ])
    if (userInput.equalsIgnoreCase("YES")) {
      // Backend builder up?
      script {
          def output = sh(returnStdout: true,
            script: 'curl --silent --location "http://helios.greece.local:8090/computer/rust_java_backend_node/api/json" --header "Authorization: Basic amVua2luczpxNUM3MUA8YWguR2IvZ2wzRi0rMw=="  | jq ".offline"')
          echo "Output: ${output}"
        if (output == true) {
          build job: "Restart_Docker_Builders",
          parameters: [string(Host: 'helios.greece.local')]
        }
      }

      // Run build
      build job: "Enigma_Backend"
    }
  }
  milestone 2
  stage('Frontend') {
    // Frontend builder up?

    script {
      def output = sh(returnStdout: true,
        script: 'curl --silent --location "http://helios.greece.local:8090/computer/rust_java_frontend_node/api/json" --header "Authorization: Basic amVua2luczpxNUM3MUA8YWguR2IvZ2wzRi0rMw==" | jq ".offline"')
      echo "Output: ${output}"
      if (output == true) {
        build job: "Restart_Docker_Builders",
        parameters: [string(Host: 'tanit.greece.local')]
      }
    }

    // Run build
    build job: "Enigma_Frontend"
  }
  milestone 3
  stage('Release') {
    build job: "Enigma_Release"
  }
}

