public class ShipmentStatusController {
    @AuraEnabled(cacheable=true)
public static String getShipmentStatus(){
String shipmentStatus = '';
try{
shipmentStatus = MockShippingStatusService.doGet();
}catch(exception ex){
shipmentStatus = ex.getMessage();
}
return shipmentStatus;
}
}