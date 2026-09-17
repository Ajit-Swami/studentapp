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
                    bat 'terraform init'
                    bat 'terraform apply -auto-approve'
                }
                bat 'aws eks update-kubeconfig --name my-eks-cluster --region us-west-2'
            }
        }

        stage('Build') {
            steps {
                dir('docker/studentapp/database') {
                    bat 'docker build --platform linux/amd64 -t ${REGISTRY}/studentapp-db:latest .'
                }
                dir('docker/studentapp/backend') {
                    bat 'docker build --platform linux/amd64 -t ${REGISTRY}/studentapp-be:latest .'
                }
                dir('docker/studentapp/frontend') {
                    bat 'docker build --platform linux/amd64 -t ${REGISTRY}/studentapp-fe:latest .'
                }
            }
        }

        stage('Push stage') {
            steps {
                bat 'docker push ${REGISTRY}/studentapp-db:latest'
                bat 'docker push ${REGISTRY}/studentapp-be:latest'
                bat 'docker push ${REGISTRY}/studentapp-fe:latest'
            }
        }

        stage('Deploy') {
            steps {
                dir('KUbernetes/Studentapp') {
                    bat 'kubectl apply -f Database/'
                    bat 'kubectl apply -f Backend/'
                    bat 'kubectl apply -f Frontend/'
                }
            }
        }
    }
}