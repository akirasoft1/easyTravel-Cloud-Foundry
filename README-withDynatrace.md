# easyTravel-Cloud-Foundry with Dynatrace

![easyTravel Logo](https://github.com/dynatrace-innovationlab/easyTravel-Builder/blob/images/easyTravel-logo.png)

## Prerequisites

The *deployment processes* requires access to a [Dynatrace](http://www.dynatrace.com/en/ruxit/) environment, whose configuration is stored in [config/dynatrace-settings.sh](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/config/dynatrace-settings.sh). Adapt to suit your needs. Please refer to [README.md](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/README.md) for additional steps.

## Deploy easyTravel with Dynatrace

`./deploy-withDynatrace.sh` creates the easyTravel MongoDB database service, registers a Dynatrace environment as a user-provided service and pushes the applications defined in the `manifest-withDynatrace.yml` file to Cloud Foundry. Undo via `./clean.sh`.

1) Open up the easyTravel Customer Frontend in a browser and make a booking to a destination of your choice:

![easyTravel Journey Booking](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/images/easytravel-booking.png)

2) See Dynatrace monitor the application:

![easyTravel Business Backend Process](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/images/ruxit-easytravel-backend-process.png)

![easyTravel Services](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/images/ruxit-easytravel-services.png)

![easyTravel Booking Service](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/images/ruxit-easytravel-booking-service.png)

![easyTravel Customer Frontend: Response Time Analysis](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/images/ruxit-easytravel-frontend-rta.png)

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/dynatrace-innovationlab/easyTravel-Cloud-Foundry/blob/master/LICENSE) file for details.
