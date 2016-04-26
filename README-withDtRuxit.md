# easyTravel-Cloud-Foundry with Dynatrace Ruxit

![easyTravel Logo](https://github.com/dynatrace-innovationlab/easyTravel-Builder/blob/images/easyTravel-logo.png)

## Prerequisites

The *deployment processes* requires access to a [Dynatrace Ruxit](http://www.dynatrace.com/en/ruxit/) environment, whose configuration is stored in [config/dtRuxit-settings.sh](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/config/dtRuxit-settings.sh). Adapt to suit your needs. Please refer to [README.md](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/README.md) for additional steps.

## Deploy easyTravel with Dynatrace Ruxit

`./deploy-withDtRuxit.sh` creates the easyTravel MongoDB database service, registers a Dynatrace Ruxit environment as a user-provided service and pushes the applications defined in the `manifest-withDtRuxit.yml` file to Cloud Foundry. Undo via `./clean.sh`.

1) Once the application has started, you should see the `easytravel-frontend` and `easytravel-backend` in your Ruxit environment.

2) Open up the easyTravel Customer Frontend in a browser and make a booking to a destination of your choice:

![easyTravel Logo](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/images/easytravel-booking.png)

3) See Dynatrace Ruxiit monitor the application

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/LICENSE) file for details.
