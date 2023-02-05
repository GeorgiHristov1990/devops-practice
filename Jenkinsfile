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

def imageName = "georgehristov/lamp-app:$BRANCH_NAME-$BUILD_NUMBER" 


pipeline {
  agent any
  
  environment {
      DOCKERHUB_CREDENTIALS=credentials('dockerhub')
  }


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
        sh "docker build -t ${imageName} ."
        sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login --username $DOCKERHUB_CREDENTIALS_USR --password-stdin"
        sh "docker push ${imageName}"
        sh "docker rmi ${imageName}"
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
        sh "docker rm -f lamp-app"
        echo "starting new container.."
        sh "docker run -dp 81:80 --name lamp-app ${imageName}"
      }
    }
  }
}
