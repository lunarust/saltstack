import groovy.json.*

node() {
  milestone 1
  stage('Refresh') {
    build job: "Refresh_tanit",
    parameters: [ string(name: 'service', value: "flashcards") ]
  }
  milestone 2
  stage('Backend') {
    def userInput = input(
        id: 'userInput', message: 'Should we build the Backend?', parameters: [
        [$class: 'ChoiceParameterDefinition', choices: 'YES\nNO', description: 'Build Backend?', name: 'be_build']
    ])
    if (userInput.equalsIgnoreCase("YES")) {
      // Backend builder up?
      withCredentials([string(credentialsId: 'Jenkins_Secret', variable: 'TOKEN')]) {
        script {
            def output = sh(returnStdout: true,
              script: 'curl --silent --location "http://helios.greece.local:8090/computer/rust_java_backend_node/api/json" --header "Authorization: Basic $TOKEN"  | jq ".offline"')
            echo "Output: ${output}"
          if (output == true) {
            build job: "Restart_Docker_Builders",
            parameters: [string(Host: 'helios.greece.local')]
          }
        }
      }
      // Run build
      build job: "Flashcard_Backend"
    }
  }
  milestone 3
  stage('Frontend') {
    // Frontend builder up?
    withCredentials([string(credentialsId: 'Jenkins_Secret', variable: 'TOKEN')]) {
      script {
        def output = sh(returnStdout: true,
          script: 'curl --silent --location "http://helios.greece.local:8090/computer/rust_java_frontend_node/api/json" --header "Authorization: Basic $TOKEN" | jq ".offline"')
        echo "Output: ${output}"
        if (output == true) {
          build job: "Restart_Docker_Builders",
          parameters: [string(Host: 'tanit.greece.local')]
        }
      }
    }

    // Run build
    build job: "Flashcard_Frontend"
  }
  milestone 4
  stage('Release') {
    build job: "Flashcard_Release"
  }
}

