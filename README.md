# Abode Software DevOps CI/CD Lifecycle

A reproducible sample implementation of the DevOps lifecycle assignment. The original assignment strategy PDF is retained. Because the repository did not contain the source for the referenced external `hshar/webapp` image, this repository now includes a small independent Node.js demonstration application.

## Application
- Home page: `/`
- Health endpoint: `/health`
- Runtime: Node.js 20
- Container port: 3000
- Automated tests: Node.js built-in test runner

## CI/CD flow

GitHub → Jenkins or GitHub Actions → automated tests → Docker build → container health check

The GitHub Actions workflow performs the Node.js tests, builds the Docker image, starts a temporary container, checks its health endpoint, and removes it.

## Jenkins
The Jenkinsfile checks out the repository, installs dependencies, runs tests, and builds a local Docker image. It does not deploy to production. A real Jenkins controller and agent are required to verify actual Jenkins execution.

## AWS CodeBuild
`buildspec.yml` describes the test and Docker build phases. A CodeBuild project must be configured separately. Docker builds in CodeBuild require privileged mode. No CodeBuild project or AWS resource has been created by this repository change.

## Branch strategy
Use `main` for the current GitHub Actions workflow. A separate `develop` branch and production promotion policy can be added when the target environment is defined. No production deployment is claimed.

## Verification boundaries
See [DEPLOYMENT_STATUS.md](DEPLOYMENT_STATUS.md). No AWS resources are launched; this project is designed for free GitHub-hosted CI checks.

## Repository
https://github.com/swarajsalve042/abode-devops-lifecycle
