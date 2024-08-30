pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/kadirortac/my-java-app.git'
      }
    }

    stage('Build') {
      steps {
        script {
          sh 'mvn clean package'
        }
      }
    }

    stage('Docker Build') {
      steps {
        script {
          sh 'docker build -t kadirortac35/task-java-app:latest .'
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        script {
          docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-creds') { 
            sh 'docker push kadirortac35/task-java-app:latest'
          }
        }
      }
    }

    stage('Deploy') {
      steps {
        // Use the sshagent plugin correctly
        sshagent(['ssh-key']) { // Replace 'ssh-key' with your SSH credential name in Jenkins
          script {
            sh "ssh kadirortac@192.168.1.111 'docker image pull kadirortac35/task-java-app:latest && docker container run -d -p 8081:8081 kadirortac35/task-java-app:latest'"
          }
        }
      }
    }
  }
}