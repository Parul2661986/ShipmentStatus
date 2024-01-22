@isTest
public class ShipmentStatusControllerTest {

    @isTest
    static void testGetAccessToken() {
        // Create a test User_Access_Info__mdt record
        /*User_Access_Info__mdt testUserAccessInfo = new User_Access_Info__mdt(
            DeveloperName = 'Test_User_Access_Info',
            client_id__c = 'testClientId',
            client_secret__c = 'testClientSecret',
            security_token__c = 'testSecurityToken'
        );
        insert testUserAccessInfo;*/

        // Set up the mock response for the access token callout
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator('{"access_token": "testAccessToken"}', 200));
 
        Test.startTest();
        String accessToken = ShipmentStatusController.getAccessToken();
        Test.stopTest();
 
        System.assertEquals('testAccessToken', accessToken, 'Access token retrieval failed');
    }

    @isTest
    static void testGetShipmentStatus() {
        // Set up the mock response for the mockShipmentStatus callout
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator('{"status": "Shipped"}', 200));

        // Call the getShipmentStatus method
        Test.startTest();
        String shipmentStatus = ShipmentStatusController.getShipmentStatus('ABC123');
        Test.stopTest();

        // Perform assertions
        System.assertEquals('{"status": "Shipped"}', shipmentStatus, 'Shipment status retrieval failed');
    }
 
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        private String responseBody;
        private Integer responseCode;

        public MockHttpResponseGenerator(String responseBody, Integer responseCode) {
            this.responseBody = responseBody;
            this.responseCode = responseCode;
        }

        public HttpResponse respond(HttpRequest req) {
            // Create a mock HTTP response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(responseBody);
            res.setStatusCode(responseCode);
            return res;
        }
    }
}