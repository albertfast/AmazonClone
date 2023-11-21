({
	doInit : function(component, event, helper) {
		
        component.set("v.Message",  "Button1 Initialized");
        component.set("v.Message2", "Button2 Initialized");
	},
    handleClick : function(component, event, helper) {
		
        //component.set("v.Message", "Button Clicked");
      var btn = event.getSource();
      var msg = btn.get("v.label");
     // component.set("v.Message", event.getSource().get("v.label"));
        if(msg == "ClickMe"){
            component.set("v.Message", msg);
        }else{
            component.set("v.Message", msg);
        }
	},
    anotherHandleClick : function(component, event, helper) {
		
      //component.set("v.Message2", "Another Button Clicked");
      component.set("v.Message2", event.getSource().get("v.label"));
	}
})