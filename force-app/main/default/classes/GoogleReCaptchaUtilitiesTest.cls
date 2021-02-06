@isTest
public with sharing class GoogleReCaptchaUtilitiesTest {
    @IsTest
    static void testReCaptcha(){
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockGReCaptchaResponse());
            String recaptchaResult = GoogleReCaptchaUtilities.verifyReCaptcha('123', 'testAction'); 
            system.assert(recaptchaResult.contains('Success'));
        Test.stopTest();
        
    }

    public class MockGReCaptchaResponse implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"success":true, "score":0.9, "action":"testAction"}');
            res.setStatusCode(200);
            return res;
        }
    }
}
