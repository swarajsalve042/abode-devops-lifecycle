# Abode Software DevOps CI/CD Lifecycle

[![ci](https://github.com/swarajsalve042/abode-devops-lifecycle/actions/workflows/ci.yml/badge.svg)](https://github.com/swarajsalve042/abode-devops-lifecycle/actions/workflows/ci.yml)
[![sqlserver projects validation](https://github.com/swarajsalve042/abode-devops-lifecycle/actions/workflows/sqlserver-projects-validation.yml/badge.svg)](https://github.com/swarajsalve042/abode-devops-lifecycle/actions/workflows/sqlserver-projects-validation.yml)

A reproducible sample implementation of the DevOps lifecycle assignment. The original assignment strategy PDF is retained. Because the repository did not contain the source for the referenced external `hshar/webapp` image, this repository now includes a small independent Node.js demonstration application.

## Application
- Home page: `/`
- Health endpoint: `/health`
- Runtime: Node.js 20
- Container port: 3000
- Automated tests: Node.js built-in test runner

## CI/CD flow

GitHub → Jenkins or GitHub Actions → automated tests → Docker build → container health check

The GitHub Actions workflow parses the Jenkinsfile as Groovy, performs the Node.js tests, builds the Docker image, starts a temporary container, checks its health endpoint, and removes it.

## Verified GitHub Actions evidence

[Latest successful CI, Jenkinsfile syntax and Docker validation](https://github.com/swarajsalve042/abode-devops-lifecycle/actions/runs/45573501207): Jenkinsfile Groovy syntax passed, Node.js tests passed, the Docker image built, and a temporary container passed its `/health` check.

This validates the independent sample app, not the original external `hshar/webapp` image. It is not evidence of a production deployment or a live Jenkins run.

## SQL portfolio assignments

The repository also includes three SQL Server/T-SQL assignments: ABC Fashion sales-order processing, relational design with users/roles/statuses, and Zomato restaurant analytics. Their scripts are executed in a temporary SQL Server Developer container with fictional test records by the [SQL Server Portfolio Project Validation workflow](https://github.com/swarajsalve042/abode-devops-lifecycle/actions/runs/45573290565). The run verifies all three scripts complete successfully. The ABC Fashion fixture was corrected so every customer SalesmanId has a matching salesman and primary-key columns are explicitly NOT NULL.

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


## Latest automated verification (25 November 2026)

- [Application CI, Docker and Jenkinsfile validation — successful GitHub Actions run](https://github.com/swarajsalve042/abode-devops-lifecycle/actions/runs/45575084114)
- [SQL portfolio validation — successful GitHub Actions run](https://github.com/swarajsalve042/abode-devops-lifecycle/actions/runs/45573290565)

These links document automated checks only; they do not imply production deployment or manual end-user acceptance testing.
