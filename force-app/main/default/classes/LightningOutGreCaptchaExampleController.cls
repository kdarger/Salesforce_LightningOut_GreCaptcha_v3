public with sharing class LightningOutGreCaptchaExampleController {
    @AuraEnabled
    public static string myServerSideAction(String someParameters, String recaptchaResponse){
        try {
            if(!Test.isRunningTest()){
                //The action name parameter must match the one used in javascript, which 
                //helps to validate which action the user should be allowed to perform
                String recaptchaResult = GoogleReCaptchaUtilities.verifyReCaptcha(recaptchaResponse, 'checkRobotScore'); 
                if(!recaptchaResult.contains('Success')){
                    throw new AuraHandledException('ReCAPTCHA verification failed');
                }
            }
            // do some things with the other parameters here
            return null;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
