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
        echo "building.."
      }
    }
    stage('Test') { 
      steps {
        echo "testing.."
      }
    }
       stage('Deploy') {
      // when {
      //   allOf {
      //     // changeRequest()
      //     // expression { return (branch == "main" || branch == "dev") }
      //     expression { return (BRANCH_NAME == "dev") }
      //   }
      // }
      steps {
        // step { 
        //   if (branch == "main") {
        //     echo 'This is from main'
        //   } else {
        //     echo 'This is from dev'
        //   }
        // }
        echo "deploying.."
      }
    }
  }
}
