pipeline {
    agent any

    environment {
        PATH = "C:/Program Files/Docker/Docker/resources/bin"
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
                    powershell 'terraform init'
                    powershell 'terraform apply -auto-approve'
                }
                powershell 'aws eks update-kubeconfig --name my-eks-cluster --region us-west-2'
            }
        }

        stage('Build') {
            steps {
                dir('docker/studentapp/database') {
                    powershell 'docker build --platform linux/amd64 -t ${REGISTRY}/studentapp-db:latest .'
                }
                dir('docker/studentapp/backend') {
                    powershell 'docker build --platform linux/amd64 -t ${REGISTRY}/studentapp-be:latest .'
                }
                dir('docker/studentapp/frontend') {
                    powershell 'docker build --platform linux/amd64 -t ${REGISTRY}/studentapp-fe:latest .'
                }
            }
        }

        stage('Push stage') {
            steps {
                powershell 'docker push ${REGISTRY}/studentapp-db:latest'
                powershell 'docker push ${REGISTRY}/studentapp-be:latest'
                powershell 'docker push ${REGISTRY}/studentapp-fe:latest'
            }
        }

        stage('Deploy') {
            steps {
                dir('KUbernetes/Studentapp') {
                    powershell 'kubectl apply -f Database/'
                    powershell 'kubectl apply -f Backend/'
                    powershell 'kubectl apply -f Frontend/'
                }
            }
        }
    }
}