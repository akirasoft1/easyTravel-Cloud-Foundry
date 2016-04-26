# easyTravel-Cloud-Foundry

![easyTravel Logo](https://github.com/dynatrace-innovationlab/easyTravel-Builder/blob/images/easyTravel-logo.png)

This project builds and deploys the [Dynatrace easyTravel](https://community.dynatrace.com/community/display/DL/Demo+Applications+-+easyTravel) demo application in [Cloud Foundry](https://en.wikipedia.org/wiki/Cloud_Foundry).

## Application Components

| Component | Component
|:----------|:---------
| mongodb   | A pre-populated travel database (MongoDB).
| backend   | The easyTravel Business Backend (Java).
| frontend  | The easyTravel Customer Frontend (Java).
| loadgen   | A synthetic UEM load generator (Java).

## Prerequisites

The following automated build and deployment process is based on these prerequisites:

1) *Bootstrapping* easyTravel's runtime environment requires access to an [Amazon EC2](https://aws.amazon.com/ec2/) account to run a [cf-containers-broker](https://github.com/cloudfoundry-community/cf-containers-broker) image on a [Docker Machine](https://docs.docker.com/machine/overview/) to hosts easyTravel's MongoDB database. In order to access Amazon EC2, you'll have to provide your personal AWS credentials in `~/.aws/credentials`, as described in Docker Machine's documentation on [Configuring Credentials for AWS](https://docs.docker.com/machine/drivers/aws/#configuring-credentials). Configuration is stored in [config/docker-machine-settings.sh](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/config/docker-machine-settings.sh). Adapt to suit your needs.

2) The *build process* depends on the [easyTravel-Builder](https://github.com/dynatrace-innovationlab/easyTravel-Builder) project as a *git submodule*. To obtain the entire codebase, either clone the project recursively via `git clone --recursive` or download a source distribution release from [here](https://github.com/dynatrace-innovationlab/easyTravel-Builder/releases). Configuration for building easyTravel is stored in [config/app-settings.sh](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/config/app-settings.sh). Adapt to suit your needs.

Building runs entirely in Docker, which relieves you from setting up a build environment first. If you don't have done so yet, go install [Docker](https://docs.docker.com/linux/step_one/) or the [Docker Toolbox](https://www.docker.com/products/docker-toolbox) now.

3) The *bootstrap and deployment processes* require access to a [Cloud Foundry](https://en.wikipedia.org/wiki/Cloud_Foundry) environment. Bootstrapping deletes and creates *organizations*, *spaces*, *service brokers*, *services* and *applications*, which means you will have to be an *admin*. The [cf Command Line Interface](http://docs.cloudfoundry.org/cf-cli/install-go-cli.html) has to be installed. Configuration for bootstrapping and deploying easyTravel on Cloud Foundry is stored in [config/cf-settings.sh](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/config/cf-settings.sh). Adapt to suit your needs.

## Build and Deploy easyTravel on Cloud Foundry

### 0. Bootstrap Cloud Foundry

`./cf-prepare.sh` sets up a Docker Machine instance in the Amazon EC2, runs a [cf-containers-broker](https://github.com/cloudfoundry-community/cf-containers-broker) on top and enables access to this service broker in Cloud Foundry. Undo via `./cf-clean.sh`.

### 1. Build

`./build.sh` creates the required deployment artefacts in `./app/easyTravel/deploy`.

```
.
├── app/easyTravel/deploy
    ├── backend
    │   └── backend.war
    ├── data
    │   └── easyTravel-mongodb-db.tar.gz
    ├── frontend
    │   └── frontend.war
    └── loadgen
        └── loadgen.tar.gz
```

### 2. Deploy

`./deploy.sh` creates the easyTravel MongoDB database service and pushes the applications defined in the `manifest.yml` file to Cloud Foundry. Undo via `./clean.sh`.

Please refer to [README-withDtAppMon.md](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/README-withDtAppMon.md) and [README-withDtRuxit.md](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/README-withDtRuxit.md) on how to monitor easyTravel in Cloud Foundry with [Dynatrace AppMon](http://www.dynatrace.com/en/application-monitoring/) or [Dynatrace Ruxit](http://www.dynatrace.com/en/ruxit/), respectively.

## Additional Resources

- [Docker Service Broker for Cloud Foundry](https://blog.pivotal.io/pivotal-cloud-foundry/products/docker-service-broker-for-cloud-foundry) (via [blog.pivotal.io](https://blog.pivotal.io/pivotal-cloud-foundry))
- [Deploying the Docker Broker](https://docs.cloud.gov/ops/deploying-the-docker-broker/) (via [docs.cloud.gov](https://docs.cloud.gov))
- [Docker Machine on AWS](https://docs.docker.com/machine/drivers/aws/) (via [docs.docker.com](https://docs.docker.com))

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/LICENSE) file for details.