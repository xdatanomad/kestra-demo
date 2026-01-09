# Kestra <> GitHub Integration

This solution demonstrates how to integrate Kestra with GitHub. This includes:
- Sourcing scripts from a GitHub repository.
- Committing Kestra Flows in a GitHub repository for version control and collaboration.
- Synchronizing using GitHub Actions.
- Promoting Kestra Flows to Production from a Github Pull Request.

### Prerequisites
- A Publicly accessible Kestra instance with a URL that can be reached by GitHub Actions.
- A GitHub repository to store Kestra Flows and scripts.
- A GitHub Personal Access Token (PAT) with appropriate permissions to access the repository.

## Overview

The integration consists of the following sections:

A. **Sourcing Scripts from GitHub**: how to source scripts stored in a GitHub repository and use them in Kestra Flows.
B. **Committing Kestra Flows to GitHub**: how to commit Kestra Flows to a GitHub repository for version control (ie: `dev` branch).
C. **Promoting to Production from PRs**: how to use GitHub Actions to synchronize Kestra Flows between branches (e.g., from `dev` to `main`) and promote them to Production.

<br/><br/><br/><br/>

## A. Sourcing Scripts from GitHub

