 def changeRequest() {
    def gitSCM = 'gitSCM'
    def changes = gitSCM.changes
    if (changes.length > 0) {
      return true
    } else {
      return false
    }
  }

pipeline {
  agent any
  

  stages {
    stage('Build') { 
      steps {
        echo "building from dev.."
      }
    }
    stage('Test') { 
      steps {
        echo "testing from dev.."
      }
    }
       stage('Deploy') {
      when {
        allOf {
          // changeRequest()
          expression { return (BRANCH_NAME == "main") }
        }
      }
      steps {
        // step { 
        //   if (branch == "main") {
        //     echo 'This is from main'
        //   } else {
        //     echo 'This is from dev'
        //   }
        // }
        echo "deploying from dev.."
      }
    }
  }
}
