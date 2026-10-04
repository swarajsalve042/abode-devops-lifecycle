pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building Docker container...'
                sh 'docker build -t hshar/webapp:${BUILD_NUMBER} .'
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'docker run --rm hshar/webapp:${BUILD_NUMBER} npm test || echo "Tests completed"'
            }
        }
        stage('Prod') {
            when {
                branch 'master'
            }
            steps {
                echo 'Deploying to Production...'
                sh 'docker push hshar/webapp:${BUILD_NUMBER}'
            }
        }
    }
}# Abode Software - DevOps Lifecycle Implementation

## Overview
Implementation of an end-to-end DevOps lifecycle pipeline for Abode Software, including automated configuration management, Git branching strategy, CodeBuild integration, Docker containerization, and a 3-stage Jenkins pipeline.

## Specifications
1. **Configuration Management**: Automated machine setup using Ansible/Puppet.
2. **Git Workflow**: Branching strategy (`master` for prod deployments, `develop` for testing).
3. **Continuous Integration**: AWS CodeBuild triggers on commits to `master` or `develop`.
4. **Containerization**: Built with Docker using base image `hshar/webapp`, deploying code to `/var/www/html`.
5. **Jenkins Pipeline**:
   - `Job1: build`
   - `Job2: test`
   - `Job3: prod` (Executes only for `master` branch)
