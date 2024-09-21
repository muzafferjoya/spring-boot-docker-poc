pipeline {
  environment {
    imagename = "muzafferjoya/spring-boot-poc"
    registryCredential = 'docker-hub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git([url: 'https://github.com/muzafferjoya/spring-boot-docker-poc.git', branch: 'master'])

      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build imagename
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push("$BUILD_NUMBER")
             dockerImage.push('latest')

          }
        }
      }
    }
    stage('Stop Previous Container'){
        steps{
         sh 'docker ps -f name=myspringboot -q | xargs --no-run-if-empty docker container stop'
         sh 'docker container ls -a -fname=myspringboot -q | xargs -r docker container rm'
        }
      }
    stage('Docker Run'){
        steps{
          script{
            sh 'docker run -d -p 8080:8080 --rm --name myspringboot ${imagename}:${BUILD_NUMBER}'
          }
        }
      
      }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $imagename:$BUILD_NUMBER"
         sh "docker rmi $imagename:latest"

      }
    }
  }
}
