({
	updateChild : function(component, event, helper) {
		component.set("v.childVar", "Update Child Value");
	},
    
    onChildVarChange : function(component, event, helper) {
		console.log("Child Value has changed");
        console.log("Old CHILD Value : " + event.getParam("oldValue"));
        console.log("New CHILD Value : " + event.getParam("value"));
	}
})