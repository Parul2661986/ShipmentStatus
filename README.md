# Shipment Status Lightning Web Component

## Overview
This Lightning Web Component (LWC) allows users to retrieve the shipment status by providing a tracking number. The component makes use of an Apex method (`getShipmentStatus`) to fetch the status from an external service.

## Installation
1. Deploy the `ShipmentStatusController` Apex class to your Salesforce org.
2. Deploy the `shipmentStatusComponent` Lightning Web Component to your Salesforce org.

## Usage
### Lightning Web Component
1. Add the `shipmentStatusComponent` to a Lightning App Page, Record Page, or Home Page in your Salesforce org.
2. When the component is added to a page, users can enter a tracking number in the input field.
3. Click the "Get Shipment Status" button to retrieve the shipment status.

### Apex Class - ShipmentStatusController
The `ShipmentStatusController` Apex class contains two methods:
- `getAccessToken`: Used to obtain an access token for authentication.
- `getShipmentStatus`: Used to retrieve the shipment status based on the provided tracking number.

## Apex Unit Tests
The Apex class has associated unit tests in the `ShipmentStatusControllerTest` class. These tests cover the functionality of the Apex class and use mock responses for HTTP callouts.
