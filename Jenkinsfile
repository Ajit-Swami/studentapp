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
                    sh 'CHECKPOINT_DISABLE=1 terraform init'
                    sh 'terraform apply -auto-approve'
                }
                sh 'aws eks update-kubeconfig --name my-eks-cluster --region us-west-2'
            }
        }

        stage('Build') {
            steps {
                dir('docker/studentapp/database') {
                    sh 'docker build --platform linux/amd64 -t ${REGISTRY}/studentapp-db:latest .'
                }
                dir('docker/studentapp/backend') {
                    sh 'docker build --platform linux/amd64 -t ${REGISTRY}/studentapp-be:latest .'
                }
                dir('docker/studentapp/frontend') {
                    sh 'docker build --platform linux/amd64 -t ${REGISTRY}/studentapp-fe:latest .'
                }
            }
        }

        stage('Push stage') {
            steps {
                sh 'docker push ${REGISTRY}/studentapp-db:latest'
                sh 'docker push ${REGISTRY}/studentapp-be:latest'
                sh 'docker push ${REGISTRY}/studentapp-fe:latest'
            }
        }

        stage('Deploy') {
            steps {
                dir('KUbernetes/Studentapp') {
                    sh 'kubectl apply -f Database/'
                    sh 'kubectl apply -f Backend/'
                    sh 'kubectl apply -f Frontend/'
                }
            }
        }
    }
}