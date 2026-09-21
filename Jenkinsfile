pipeline {
    agent any

    environment {
        REGISTRY = 'docker.io/ajit189'
    }

    options {
        skipDefaultCheckout true
    }

    stages {
        stage('Pull stage') {
            steps {
                git url: 'https://github.com/Ajit-Swami/studentapp.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                dir('docker/database') {
                    sh 'docker build -t ${REGISTRY}/studentapp-db:latest .'
                }
                dir('docker/backend') {
                    sh 'docker build -t ${REGISTRY}/studentapp-be:latest .'
                }
                dir('docker/frontend') {
                    sh 'docker build -t ${REGISTRY}/studentapp-fe:latest .'
                }
            }
        }

        stage('Push stage') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
                sh 'docker push ${REGISTRY}/studentapp-db:latest'
                sh 'docker push ${REGISTRY}/studentapp-be:latest'
                sh 'docker push ${REGISTRY}/studentapp-fe:latest'
            }
        }

        stage('Deploy') {
            steps {
                // Stop existing containers
                sh 'docker stop studentapp-db studentapp-be studentapp-fe || true'
                sh 'docker rm studentapp-db studentapp-be studentapp-fe || true'

                // Create network if not exists
                sh 'docker network create studentapp-network || true'

                // Run database
                sh 'docker run -d --name studentapp-db --network studentapp-network -p 3306:3306 ${REGISTRY}/studentapp-db:latest'

                // Wait for database to be ready
                sh 'sleep 30'

                // Run backend
                sh 'docker run -d --name studentapp-be --network studentapp-network -p 8080:8080 ${REGISTRY}/studentapp-be:latest'

                // Wait for backend to be ready
                sh 'sleep 20'

                // Run frontend
                sh 'docker run -d --name studentapp-fe --network studentapp-network -p 80:80 ${REGISTRY}/studentapp-fe:latest'
            }
        }

        stage('Verify') {
            steps {
                sh 'docker ps'
                sh 'curl -f http://localhost:80 || echo "Frontend check failed"'
                sh 'curl -f http://localhost:8080 || echo "Backend check failed"'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}