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
                    sh 'docker build -t kadirortac35/my-java-app:latest .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'my-dockerhub-credentials') {
                        sh 'docker push kadirortac35/my-java-app:latest'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                sshagent(['ssh-key-java-app']) {
                    sh '''
                    ssh kadirortac@192.168.1.208 "
                        docker pull kadirortac35/my-java-app:latest &&
                        docker stop $(docker ps -q --filter ancestor=kadirortac35/my-java-app:latest) &&
                        docker rm $(docker ps -q --filter ancestor=kadirortac35/my-java-app:latest) &&
                        docker run -d -p 8080:8080 kadirortac35/my-java-app:latest
                    "
                    '''
                }
    }
}

    }
}
