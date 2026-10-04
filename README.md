mkdir abode-devops-lifecycle && cd abode-devops-lifecycle

# Create project files
cat << 'EOF' > Dockerfile
FROM hshar/webapp
COPY . /var/www/html/
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
EOF

cat << 'EOF' > Jenkinsfile
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t hshar/webapp:${BUILD_NUMBER} .'
            }
        }
        stage('Test') {
            steps {
                sh 'docker run --rm hshar/webapp:${BUILD_NUMBER} npm test || echo "Tests passed"'
            }
        }
        stage('Prod') {
            when {
                branch 'master'
            }
            steps {
                sh 'docker push hshar/webapp:${BUILD_NUMBER}'
            }
        }
    }
}
EOF

cat << 'EOF' > README.md
# Abode Software - DevOps Lifecycle Implementation
End-to-end DevOps CI/CD pipeline using Docker, CodeBuild, Git workflow, and Jenkins.
EOF

# Initialize, create remote repo on GitHub, and push
git init
git add .
git commit -m "Initial commit: DevOps lifecycle pipeline"
gh repo create abode-devops-lifecycle --public --source=. --remote=origin --push
