/*
* Perform server side validation of google recaptcha v3
*/

public with sharing class GoogleReCaptchaUtilities {
    public static String SITE_KEY { get {return '<<REPLACE WITH YOUR SITE KEY>>';}}
    private static String SECRET_KEY = '<<REPLACE WITH YOUR SECRET KEY>>';
    // The threshold determines the score required to move forward.
    // Below this threshold, consider adding additional verification actions, like an 
    // email verification.
    // Consider having different thresholds based on the action being performed
    // and store thresholds in custom metadata. 
    private static Decimal threshold = .4;  
        
    @AuraEnabled
    public static String verifyReCaptcha(String recaptchaResponse, String actionName){
        //https://developers.google.com/recaptcha/docs/verify
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.google.com/recaptcha/api/siteverify');
        request.setMethod('POST');
        request.setBody('secret=' + SECRET_KEY + '&response=' + recaptchaResponse);
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            System.debug(response.getBody());
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

            if (result.containsKey('success') && result.get('success') == true) {
                if (result.containsKey('score')) {
                    //score logic is only needed/returned for v3 (0.0 - 1.0)
                    //https://developers.google.com/recaptcha/docs/v3
                    String action = (String)result.get('action');
                    Decimal score = (Decimal)result.get('score');
                    if (score > threshold && action == actionName) {
                        return 'Success - v3';
                    }
                } else {
                    return 'Success - v2';
                }
            } else {
                return 'Invalid Verification';
            }
        }
        //consider letting this through
        return 'Invalid Verification Request';
    }
}
