import { LightningElement, track, api } from 'lwc';
import getShipmentStatus from '@salesforce/apex/ShipmentStatusController.getShipmentStatus';

export default class ShipmentStatus extends LightningElement {
    @api trackingNumber;
    @track shipmentStatus;

    handleTrackingNumberChange(event) {
        this.trackingNumber = event.target.value;
    }

    getShipmentStatus() {
        if (this.trackingNumber) {
            getShipmentStatus({ trackingNumber: this.trackingNumber })
                .then(result => {
                    this.shipmentStatus = result;
                })
                .catch(error => {
                    console.error('Error retrieving shipment status', error);
                    this.shipmentStatus = 'Error - Unable to fetch shipment status.';
                });
        } else {
            this.shipmentStatus = 'Please enter a tracking number.';
        }
    }
    
}
