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
        stage('Docker Buildx') {
            steps {
                script {
                    // Docker Buildx kullanarak çoklu platform desteği ile Docker imajı oluşturma
                    sh '''
                    docker buildx create --use
                    docker buildx build --platform linux/amd64,linux/arm64 -t kadirortac35/my-java-app:latest .
                    '''
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
                sshagent(['java-app-ssh-key']) {
                    sh '''
                    ssh kadirortac@192.168.1.208 "docker pull kadirortac35/my-java-app:latest"
                    ssh kadirortac@192.168.1.208 "docker run -d -p 8080:8080 kadirortac35/my-java-app:latest"
                    '''
                }
            }
        }
    }
}
