pipeline {
    agent any

    stages {
        stage('Job1 - Build') {
            steps {
                checkout scm
                sh 'docker build -t hshar/webapp:$BUILD_NUMBER .'
            }
        }

        stage('Job2 - Test') {
            steps {
                sh 'echo "Run application tests here"'
                sh 'docker run --rm hshar/webapp:$BUILD_NUMBER true'
            }
        }

        stage('Job3 - Prod') {
            when {
                branch 'master'
            }
            steps {
                sh 'echo "Deploy tested image to production here"'
            }
        }
    }

    post {
        success { echo 'Build/Test pipeline completed successfully.' }
        failure { echo 'Pipeline failed. Production promotion is blocked.' }
    }
}
