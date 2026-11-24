# Deployment and verification status

This repository now includes an independently written Node.js sample application. It is not the original `hshar/webapp` image or its source code.

## Safe verification
- Node.js unit tests run in GitHub Actions.
- Docker image build runs in GitHub Actions.
- The container is started temporarily by the workflow and its `/health` endpoint is checked.
- The temporary container is removed at the end of the job.

## Not performed
- No AWS resources are created.
- No Jenkins controller or agent is provisioned and no live Jenkins pipeline execution is claimed.
- No production deployment is performed.
- AWS CodeBuild requires a configured project and a privileged build environment for Docker-in-Docker; this repository only contains a build specification.

The original assignment PDF and its intended architecture are retained. The sample application is a reproducible demonstration used to make the repository's build and test steps verifiable without paid infrastructure.
