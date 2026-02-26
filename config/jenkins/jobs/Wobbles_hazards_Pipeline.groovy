import groovy.json.*
def LSSPROP = []

node() {
  milestone 1
  stage('Build'){
    def FETCH = sh (
        script: "cd /var/jenkins_home/Wobbles_hazards/Checkout && git fetch --depth=1 origin main && git diff --name-only origin/main main | cut -d'/' -f1 | sort -u",
        returnStdout: true
    )
    build job: 'Wobbles_hazards/Checkout'
    def LSSP = FETCH.split('\n')
    println "Fetch command resulted with: $LSSP"
    for (prj in LSSP) {
      if (prj != "") {
        LSSPROP << "$prj"
        println "#### Engaging build for $prj"
        build job: 'Wobbles_hazards/Build', parameters: [string(name: 'app', value: prj)]
    }}
  }
  milestone 2
  stage('Release'){
    for (prj in LSSPROP) {
      def filename = prj
      println "Engaging release for $prj"
      if (prj != "") {
        if (prj == "push_phone") {
           build job: 'Wobbles_hazards/ReleaseLibrary'
        }
        else {
          build job: 'Wobbles_hazards/Release', parameters: [string(name: 'app', value: prj)]
        }
      }
      else { println "### Nothing to do here" }
    }
  }
  milestone 3
  stage('Refresh Salt'){
    def saltresult_refresh = salt authtype: 'pam',
      clientInterface: local(arguments: '"saltenv=host_scripts"', blockbuild: true,
      function: 'state.highstate', jobPollTime: 16,
      target: 'bors.greece.local', targettype: 'glob'),
      credentialsId: 'f6cb0e72-3691-40c6-aea0-aa768887c9bf',
      servername: 'http://192.168.1.217:8080'
    def prettyJson = JsonOutput.prettyPrint(saltresult_refresh)

    println(prettyJson)
  }
}
