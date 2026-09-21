pipeline {
    agent any

    environment {
        REGISTRY = 'docker.io/ajit189'
        aws_access_key = credentials('aws-access-key')
        aws_secret_key = credentials('aws-secret-key')
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

        stage('Infrastructure') {
            steps {
                dir('Terraform/eks-modules') {
                    sh 'export AWS_ACCESS_KEY_ID=${aws_access_key} && export AWS_SECRET_ACCESS_KEY=${aws_secret_key} && terraform init -upgrade'
                    sh 'export AWS_ACCESS_KEY_ID=${aws_access_key} && export AWS_SECRET_ACCESS_KEY=${aws_secret_key} && terraform apply -auto-approve'
                }
                sh 'export AWS_ACCESS_KEY_ID=${aws_access_key} && export AWS_SECRET_ACCESS_KEY=${aws_secret_key} && aws eks update-kubeconfig --name my-eks-cluster --region us-west-2'
            }
        }

        stage('Build') {
            steps {
                dir('docker/database') {
                    sh 'docker build --platform linux/amd64 -t ${REGISTRY}/studentapp-db:latest .'
                }
                dir('docker/backend') {
                    sh 'docker build --platform linux/amd64 -t ${REGISTRY}/studentapp-be:latest .'
                }
                dir('docker/frontend') {
                    sh 'docker build --platform linux/amd64 -t ${REGISTRY}/studentapp-fe:latest .'
                }
            }
        }

        stage('Push stage') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'docker-hub-credentials',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login docker.io -u "$DOCKER_USER" --password-stdin

                        docker push ${REGISTRY}/studentapp-db:latest
                        docker push ${REGISTRY}/studentapp-be:latest
                        docker push ${REGISTRY}/studentapp-fe:latest

                        docker logout docker.io
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                dir('Kubernetes/Studentapp') {
                    sh 'kubectl apply -f Database/'
                    sh 'kubectl apply -f Backend/'
                    sh 'kubectl apply -f Frontend/'
                }
            }
        }
    }
}