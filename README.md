# Abode Software DevOps CI/CD Lifecycle

Professional DevOps implementation project based on the Abode Software assignment.

## Architecture

GitHub → Jenkins → AWS CodeBuild → Docker → Test → Production

## Branch Strategy

- **master**: build → test → production deployment
- **develop**: build → test only; no production deployment

## Jenkins Jobs

1. **Job1 - Build** — checkout source and build the Docker image.
2. **Job2 - Test** — run automated/application validation.
3. **Job3 - Prod** — deploy only when the source branch is **master**.

## Docker

Pre-built application container: `hshar/webapp`

Application location: `/var/www/html`

The Docker image is rebuilt whenever source code is pushed to GitHub.

## AWS CodeBuild

`buildspec.yml` provides the CodeBuild build configuration. Configure the CodeBuild webhook/source trigger for pushes to the **master** and **develop** branches.

## Configuration Management

Use a configuration-management tool such as Ansible to install and standardize Docker, Jenkins agents, Git, AWS tooling and other required dependencies on target machines.

## Deliverables

- `Dockerfile`
- `Jenkinsfile`
- `buildspec.yml`
- DevOps Lifecycle Implementation Strategy PDF
- Professional project presentation

## Repository

https://github.com/swarajsalve042/abode-devops-lifecycle
