# Docker image for running Sonar Scanner CLI in an Azure Pipelines container job

<!-- markdownlint-disable MD013 -->
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/swissgrc/docker-azure-pipelines-sonarscannercli/blob/main/LICENSE) [![Build](https://img.shields.io/github/actions/workflow/status/swissgrc/docker-azure-pipelines-sonarscannercli/publish.yml?branch=develop&style=flat-square)](https://github.com/swissgrc/docker-azure-pipelines-sonarscannercli/actions/workflows/publish.yml) [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=swissgrc_docker-azure-pipelines-sonarscannercli&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=swissgrc_docker-azure-pipelines-sonarscannercli) [![Pulls](https://img.shields.io/docker/pulls/swissgrc/azure-pipelines-sonarscannercli.svg?style=flat-square)](https://hub.docker.com/r/swissgrc/azure-pipelines-sonarscannercli) [![Stars](https://img.shields.io/docker/stars/swissgrc/azure-pipelines-sonarscannercli.svg?style=flat-square)](https://hub.docker.com/r/swissgrc/azure-pipelines-sonarscannercli)
<!-- markdownlint-restore -->

Docker image to run [Sonar Scanner CLI] in [Azure Pipelines container jobs].

## Usage

This image can be used to run Sonar Scanner CLI in [Azure Pipelines container jobs].

### Azure Pipelines Container Job

To use the image in an Azure Pipelines Container Job, add one of the following example tasks and use it with the `container` property.

The following example shows the container used for a deployment step which shows .NET version:

```yaml
  - stage: Build
    jobs:
    - job: Build
      steps:
      - task: SonarCloudPrepare@1
        displayName: 'Prepare analysis configuration'
        target: swissgrc/azure-pipelines-sonarscannercli:latest
        inputs:
          SonarCloud: 'SonarCloud'
          organization: 'myOrganization'
          scannerMode: 'CLI'
          configMode: 'manual'
          cliProjectKey: 'my-project'
          cliProjectName: 'MyProject'
          cliSources: '.'
```

### Tags

| Tag        | Description                                                                                   | Base Image                                | Size                                                                                                                                     |
|------------|-----------------------------------------------------------------------------------------------|-------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| latest     | Latest stable release (from `main` branch)                                                    | swissgrc/azure-pipelines-openjdk:17.0.4.0 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-sonarscannercli/latest?style=flat-square)   |
| unstable   | Latest unstable release (from `develop` branch)                                               | swissgrc/azure-pipelines-openjdk:17.0.5.0 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-sonarscannercli/unstable?style=flat-square) |

### Configuration

These environment variables are supported:

| Environment variable   | Default value              | Description                                                      |
|------------------------|----------------------------|------------------------------------------------------------------|
| NODE_VERSION           | `18.15.0-deb-1nodesource1` | Version of Node.js installed in the image.                       |

[Sonar Scanner CLI]: https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/
[Azure Pipelines container jobs]: https://docs.microsoft.com/en-us/azure/devops/pipelines/process/container-phases
