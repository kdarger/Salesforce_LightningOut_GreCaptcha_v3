# Google ReCAPTCHA v3 for Use with Lightning Out on Visualforce Pages

Additional setup: add https://www.google.com as a remote site 

## How Does it Work?

https://developers.google.com/recaptcha/docs/v3

Locker service will not allow Google's scripts to be loaded directly into 
lightning components. Instead: 
1. The parent Visualforce page loads Google's reCAPTCHA JavaScript API. 
2. The lightning component uses an Aura event (grecaptchaExecute) to have the visualforce page programatically invoke the challenge. 
3. The resulting token and action name is passed back to the lightning component via an different Aura event (grecaptchaVerified). 
4. The lightning component then passes that token to the server's @AuraEnabled apex method. 
5. That method verifies the token using the GoogleReCaptchaUtilities. 
6. If the verification goes through, the apex method completes the remaining actions. Otherwise, it throws an error. 

ReCAPTCHA v3 does not interput users, so it only provides a score that must be handled by the apex class. See documentation for ideas on how to handle these scores. This implementation simply throws an error for scores under a threshold set in GoogleReCaptchaUtilities. 
