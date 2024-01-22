public class ShipmentStatusController {
    @AuraEnabled 
    public static string getAccessToken(){ 
        User_Access_Info__mdt[] UserAccessInfo = [SELECT DeveloperName, client_id__c, client_secret__c, security_token__c FROM User_Access_Info__mdt WHERE DeveloperName = 'User_Access_Info'];
        String clientId = 'UserAccessInfo[0].client_id__c';
        String clientSecret = 'UserAccessInfo[0].client_secret__c';
        String securityToken = 'UserAccessInfo[0].security_token__c';
        
        HttpRequest req = new HttpRequest(); 
        req.setEndpoint('callout:Salesforce_Integration'+'/services/oauth2/token');
        req.setBody('grant_type=password' +
                    '&client_id=' + clientId +
                    '&client_secret=' + clientSecret +
                    '&username=' + '{!$Credential.Username}' +
                    '&password=' + '{!$Credential.Password}' + securityToken
                   );
        req.setMethod('POST');
        
        Http http = new Http();
        HttpResponse res = http.send(req); 
        if (res.getStatusCode() == 200) {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            return (String) responseMap.get('access_token');
        } else { 
            return 'Error - ' + res.getStatusCode() + ': ' + res.getStatus();
        } 
    }
    
    @AuraEnabled(cacheable=true)
    public static String getShipmentStatus(String trackingNumber){ 
        // Create an HTTP request
        HttpRequest request = new HttpRequest();
        String sfdcURL = URL.getSalesforceBaseUrl().toExternalForm();
        String restAPIURL = sfdcURL + '/services/apexrest/mockShipmentStatus';
        request.setEndpoint(restAPIURL + '?trackingNumber=' + EncodingUtil.urlEncode(trackingNumber, 'UTF-8')); 
        request.setHeader('Authorization', 'Bearer ' + getAccessToken());   
        request.setMethod('GET');
        
        // Create an HTTP object to send the request
        Http http = new Http();
        HttpResponse response = http.send(request);
        
        // Process the response
        if (response.getStatusCode() == 200) {
            System.debug(response.getBody());
            return response.getBody();
        } else {
            return 'Error - Unable to fetch shipment status. HTTP Status Code: ' + response.getStatusCode();
        } 
    }
}
