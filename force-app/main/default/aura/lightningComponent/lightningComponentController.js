({
    grecaptchaHandler : function(component, event, helper){
        //handle grepatcha event that is fired by the visualforce page on grecaptcha response
        let action = event.getParam('action'); 
        let recaptchaResponse = event.getParam('response'); 
        switch (action){
            //add other actions here
            case 'checkRobotScore': 
                helper.checkRobotScore(component, recaptchaResponse); 
                break; 
        }
    },
    checkRobotStatus :  function(component, event, helper){
        helper.grecaptchaAction('checkRobotScore'); 
    }

})
