
def imageName = "georgehristov/lamp-app:$BRANCH_NAME-$BUILD_NUMBER" 

pipeline {
  agent any
  
  environment {
      DOCKERHUB_CREDENTIALS=credentials('dockerhub')
      PROJECT_ID = 'kodekloud-gcp-training-375813'
      CLUSTER_NAME = 'cluster-1'
      LOCATION = 'europe-central2-a'
      CREDENTIALS_ID = 'kodekloud-gcp-training'
  }


    stage('Build and Push Docker image') { 
      steps {
        echo "building image and pushing.."
        sh "docker build -t ${imageName} ."
        sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login --username $DOCKERHUB_CREDENTIALS_USR --password-stdin"
        sh "docker push ${imageName}"
        // sh "docker rmi ${imageName}"
      }
    }
     
    stage('Deploy') {
      // steps {
      //   echo "deploying.."
      //   echo "removing old container.."
      //   sh "docker rm -f lamp-app"
      //   echo "starting new container.."
      //   sh "docker run -dp 81:80 --name lamp-app ${imageName}"
      // }
      steps {
          sh "echo /${imageName}/"
          sh "pwd"
          sh "sed -i \"s|image-name|${imageName}|g\" ./k8s-specifications/deployment.yml"
          step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'k8s-specifications/deployment.yml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
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
