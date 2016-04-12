# easyTravel-Cloud-Foundry

![easyTravel Logo](https://github.com/dynatrace-innovationlab/easyTravel-Builder/blob/images/easyTravel-logo.png)

This project builds and deploys deployment artefacts of the [Dynatrace easyTravel](https://community.dynatrace.com/community/display/DL/Demo+Applications+-+easyTravel) demo application for the following components on a Pivotal Cloud Foundry cluster:

## Application Components

| Component   | Deployment Artefact
|:------------|--------------------
| repository  | A pre-populated travel database (MongoDB) as `easyTravel-mongodb-db.tar.gz`.
| backend     | The easyTravel Business Backend (Java) as `backend.war`
| frontend    | The easyTravel Customer Frontend (Java) as `frontend.war`.
| loadgen     | A synthetic UEM load generator (Java) as `uemload.jar` plus dependencies in `loadgen.tar.gz`.

## How to build easyTravel?

```
./scripts/create-docker-machine-aws.sh
./scripts/deploy-cf-containers-broker.sh
```

```
./build-app.sh
```

```
./scripts/login-cloud-foundry.sh
./deploy-app.sh
```

## Resources

- https://blog.pivotal.io/pivotal-cloud-foundry/products/docker-service-broker-for-cloud-foundry
- https://docs.cloud.gov/ops/deploying-the-docker-broker/
- https://docs.docker.com/machine/drivers/aws/