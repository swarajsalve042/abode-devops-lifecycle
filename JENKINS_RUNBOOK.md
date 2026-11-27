# Jenkins execution runbook

Repository: https://github.com/swarajsalve042/abode-devops-lifecycle

## Purpose

Run the repository's actual Jenkins Declarative Pipeline on a Jenkins controller and build agent. GitHub Actions checks Groovy syntax and independently tests the application; those checks do not execute this Jenkinsfile.

## Prerequisites

- Jenkins 2.x or later.
- Jenkins Pipeline and Git plugins.
- A Linux build agent with Node.js 20+, npm, Docker CLI, and access to a running Docker daemon.
- The Jenkins agent account must be permitted to use the Docker daemon. Do not solve this by exposing an unauthenticated remote Docker socket.

The Jenkinsfile performs an agent preflight and fails before dependency installation if Node.js, npm, Docker, or Docker daemon access is missing.

## Configure the job

1. In Jenkins, select **New Item** and create a **Pipeline** job.
2. Under **Pipeline**, choose **Pipeline script from SCM**.
3. Select **Git** and enter: `https://github.com/swarajsalve042/abode-devops-lifecycle.git`.
4. Set branch specifier to `*/main` and script path to `Jenkinsfile`.
5. Save and select **Build Now**.
6. Inspect the Console Output. Confirm Checkout, Agent Preflight, Install and Test, and Build Docker Image all succeed.

## Expected result

A local image named `abode-devops-demo:<BUILD_NUMBER>` is built on the Jenkins agent. No registry push, AWS resource creation, or production deployment is performed.

## Evidence required before marking Jenkins complete

Record the Jenkins build URL and build number, and confirm the four pipeline stages completed successfully. A Groovy parse or GitHub Actions run is not a substitute for this live Jenkins evidence.

## Troubleshooting

- **Node/npm missing or old:** install Node.js 20+ on the actual build agent and ensure its PATH is available to the Jenkins service.
- **Docker command missing:** install Docker CLI on the agent.
- **Cannot connect to Docker daemon:** start the daemon and grant the Jenkins agent account approved access; then rerun.
- **Checkout fails:** verify the agent can reach GitHub. This repository is public, so no personal access token is needed for read-only checkout.
