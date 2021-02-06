({
    grecaptchaAction : function(actionName){
        //fire grecaptcha execute, which is handled by the visualforce page
        var grecaptchaExecute = $A.get("e.c:grecaptchaExecute"); 
        grecaptchaExecute.setParams({action: actionName}); 
        grecaptchaExecute.fire(); 
    },
    checkRobotScore : function(component, recaptchaResponse){
        //do a server side check of the recaptchaResponse
        //and any other server side actions this function should handle 
        //(Handle in the same serverside function!)
        var action = component.get("c.myServerSideAction"); 
        action.setParams({ 
            "someParameters" : "Whatever you need to pass", 
            recaptchaResponse: recaptchaResponse
        });
        action.setCallback(this,function(result) {
            var state=result.getState();
            if(state=="SUCCESS") {
                component.set('v.robotStatus', 'You are probably not a robot.'); 
            } else{
                component.set('v.robotStatus', 'I think you might be a robot.');
            }
        });
        $A.enqueueAction(action); 
    }
})
