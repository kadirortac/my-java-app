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
          sh 'docker build -t kadirortac35/java-app:latest .'
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        script {
          docker.withRegistry('https://index.docker.io/v1/', 'docker-hub') { 
            sh 'docker push kadirortac35/java-app:latest'
          }
        }
      }
    }

    stage('Deploy') {
      steps {
        // Use the sshagent plugin correctly
        sshagent(['ssh-key']) { // Replace 'ssh-key' with your SSH credential name in Jenkins
          script {
           // Create the .ssh directory if it doesn't exist
            sh 'mkdir -p /var/lib/jenkins/.ssh'
            // Give Jenkins write permissions to the directory
            sh 'chmod 700 /var/lib/jenkins/.ssh'

            // Add the server's host key to known_hosts
            sh "ssh-keyscan 192.168.1.185 >> /var/lib/jenkins/.ssh/known_hosts"

            // Option 2: Disable strict host key checking (NOT RECOMMENDED for production)
            // sh "ssh -o StrictHostKeyChecking=no kadirortac@192.168.1.185 'docker image pull kadirortac35/java-app:latest && docker container run -d -p 8081:8081 kadirortac35/java-app:latest'"

            // Recommended:  Use a more secure approach like Ansible or a dedicated deployment tool
            sh "ssh kadirortac@192.168.1.185 'docker image pull kadirortac35/java-app:latest && docker container run -d -p 8081:8081 kadirortac35/java-app:latest'"
          }
        }
      }
    }
  }
}