def tag = "$BRANCH_NAME-$BUILD_NUMBER"
def app_image = "georgehristov/lamp-app_apache-php" 
def db_image = "georgehristov/lamp-app_db" 

pipeline {
  agent any
  
    environment {
        DOCKERHUB_CREDENTIALS=credentials('dockerhub')
        PROJECT_ID = 'kodekloud-gcp-training-375813'
        CLUSTER_NAME = 'cluster-1'
        LOCATION = 'europe-central2-a'
        CREDENTIALS_ID = 'kodekloud-gcp-training'
    }

 stages {
  stage('Build and Push Docker image') { 
    steps {
      echo "building image and pushing.."
      script {
          docker build -f Dockerfile-phphttpd -t ${app_image}:${tag} .
          docker build -f Dockerfile-phphttpd -t ${app_image}:latest .
          docker build -f Dockerfile-db -t ${db_image}:${tag} .
          docker build -f Dockerfile-db -t ${db_image}:latest .
          echo $DOCKERHUB_CREDENTIALS_PSW | docker login --username $DOCKERHUB_CREDENTIALS_USR --password-stdin
          echo $(id)
          echo $(pwd)
          docker push ${app_image}:${tag}
          docker push ${app_image}
          docker push ${db_image}:${tag}
          docker push ${db_image}
        }
      // sh "docker rmi ${imageName}"
    }
  }
     
  stage('Deploy') {
    steps {
      sh "echo deploying.."
    }
  }

  stage ('Clean up') {
    steps {
      sh "echo cleaning up"
      // sh "rm -rf $pwd/workspace/*"
    }
  }
 }
}