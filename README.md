# easyTravel-Cloud-Foundry

![easyTravel Logo](https://github.com/dynatrace-innovationlab/easyTravel-Builder/blob/images/easyTravel-logo.png)

This project builds and deploys the [Dynatrace easyTravel](https://community.dynatrace.com/community/display/DL/Demo+Applications+-+easyTravel) demo application in [Cloud Foundry](https://en.wikipedia.org/wiki/Cloud_Foundry).

## Application Components

| Component   | Deployment Artefact
|:------------|--------------------
| persistence  | A pre-populated travel database (MongoDB) as `easyTravel-mongodb-db.tar.gz`.
| backend     | The easyTravel Business Backend (Java) as `backend.war`
| frontend    | The easyTravel Customer Frontend (Java) as `frontend.war`.
| loadgen     | A synthetic UEM load generator (Java) as `uemload.jar` and dependencies in `loadgen.tar.gz`.

## Prerequisites

The following automated build and deployment process is based on these prerequisites:

- This project uses the [easyTravel-Builder](https://github.com/dynatrace-innovationlab/easyTravel-Builder) project. The fully automated build process runs inside a Docker container, which relieves you from the need to set up a build environment first. If you don't have done so yet, go install [Docker](https://docs.docker.com/linux/step_one/) or the [Docker Toolbox](https://www.docker.com/products/docker-toolbox) now.
- The process requires access to a [Cloud Foundry](https://en.wikipedia.org/wiki/Cloud_Foundry) environment. Preparing and cleaning the cluster via `cf-prepare.sh` and `cf-clean.sh`, respectively, creates and deletes *organizations*, *spaces*, *service brokers*, *services* and *applications* (which means you'll have to be an *admin*). You'll also need to install the [cf Command Line Interface](http://docs.cloudfoundry.org/cf-cli/install-go-cli.html).
- The process requires access to an [Amazon EC2](https://aws.amazon.com/ec2/) account to spin up a [Docker Machine](https://docs.docker.com/machine/overview/) instance to run a [cf-containers-broker](https://github.com/cloudfoundry-community/cf-containers-broker) that will host easyTravel's MongoDB database. Information on how to configure your AWS credentials for Docker Machine can be found [here](https://docs.docker.com/machine/drivers/aws/#configuring-credentials).

## 0. Bootstrap

`./cf-prepare.sh` sets up a Docker Machine instance, deploys a [cf-containers-broker](https://github.com/cloudfoundry-community/cf-containers-broker) and enables access to this service broker in the cluster. Configuration is stored in the following files (adapt to suit your needs):

- [config/cf-settings.sh](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/config/cf-settings.sh)
- [config/docker-machine-settings.sh](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/config/docker-machine-settings.sh)

## 1. Build

`./build.sh` creates the required deployment artefacts in `./app/easyTravel/deploy`.

```
.
├── app
    └── easyTravel
        └── deploy
            ├── backend
            │   └── backend.war
            ├── data
            │   └── easyTravel-mongodb-db.tar.gz
            ├── frontend
            │   └── frontend.war
            └── loadgen
                └── loadgen.tar.gz
```

Configuration is stored in the following files (adapt to suit your needs):

- [config/cf-settings.sh](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/config/cf-settings.sh)

## 2. Deploy

`./deploy.sh` creates the easyTravel MongoDB database service and pushes the applications defined in the `manifest.yml` file. Configuration is stored in the following files (adapt to suit your needs):

- [config/cf-settings.sh](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/config/cf-settings.sh)
- [config/docker-machine-settings.sh](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/config/docker-machine-settings.sh)

## Additional Resources

- [Docker Service Broker for Cloud Foundry](https://blog.pivotal.io/pivotal-cloud-foundry/products/docker-service-broker-for-cloud-foundry)
- [Deploying the Docker Broker](https://docs.cloud.gov/ops/deploying-the-docker-broker/)
- [Docker Machine on AWS](https://docs.docker.com/machine/drivers/aws/)

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/LICENSE) file for details.