 def changeRequest() {
    def gitSCM = 'gitSCM'
    def changes = gitSCM.changes
    if (changes.length > 0) {
      return true
    } else {
      return false
    }
  }

  // parameters {
  //   string(name: 'imageName', defaultValue: 'my-image', description: 'The name of the image to be built')
  // }

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
    stage('Build and Push Docker image') { 
      steps {
        echo "testing from dev.."
        sh "docker build -t georgehristov/lamp-app:$BRANCH_NAME-$BUILD_NUMBER ."

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
        echo "deploying from dev.."
        echo "removing old container.."
        sh "docker rm -f \$(docker ps -aq)"
        echo "starting new container.."
        sh "docker run -dp 81:80 georgehristov/lamp-app:$BRANCH_NAME-$BUILD_NUMBER"
      }
    }
  }
}
