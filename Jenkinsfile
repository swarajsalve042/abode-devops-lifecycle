pipeline {
    agent any

    environment {
        IMAGE_NAME = 'abode-devops-demo'
    }

    stages {
        stage('Checkout') {
            steps { checkout scm }
        }

        stage('Install and Test') {
            steps {
                sh 'node --version'
                sh 'npm install'
                sh 'npm test'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .'
            }
        }
    }

    post {
        success { echo 'Build, automated tests and local Docker image build completed.' }
        failure { echo 'Pipeline failed. Review the stage logs; no deployment was attempted.' }
    }
}
