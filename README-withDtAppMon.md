# easyTravel-Cloud-Foundry with Dynatrace AppMon

![easyTravel Logo](https://github.com/dynatrace-innovationlab/easyTravel-Builder/blob/images/easyTravel-logo.png)

## Prerequisites

The *deployment processes* requires access to a [Dynatrace Application Monitoring]() server instance, whose configuration is stored in [config/dtAppMon-settings.sh](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/config/dtAppMon-settings.sh). Adapt to suit your needs. Please refer to [README.md](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/README.md) for additional steps.

## Deploy easyTravel with Dynatrace AppMon

`./deploy-withDtAppMon.sh` creates the easyTravel MongoDB database service, registers a managed Dynatrace Server instance as a user-provided service and pushes the applications defined in the `manifest-withDtAppMon.yml` file to Cloud Foundry. Undo via `./clean.sh`.

1) Once the application has started, you should see the `easytravel-frontend` and `easytravel-backend` agents connected:

![easyTravel Logo](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/images/dynatrace-agents-overview.png)

2) Open up the easyTravel Customer Frontend in a browser and make a booking to a destination of your choice:

![easyTravel Logo](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/images/easytravel-booking.png)

3) See Dynatrace AppMon monitor the application:

![easyTravel Logo](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/images/easytravel-transaction-flow.png)

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/LICENSE) file for details.