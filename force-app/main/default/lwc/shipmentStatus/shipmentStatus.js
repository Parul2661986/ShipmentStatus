import { LightningElement } from 'lwc';
import doGet from '@salesforce/apex/MockShippingStatusService.doGet'
export default class ShipmentStatus extends LightningElement {
trackingStatus = '';
error = '';
connectedCallback(){
getShipmentStatus();
}
getShipmentStatus(){
doGet()
.then((result) => {
this.trackingStatus = result;
console.log('result..'+this.trackingStatus);
})
.catch((error) => {
this.error = error;
});
}
}