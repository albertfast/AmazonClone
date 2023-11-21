({
	doInit : function(component, event, helper) {
		//component.set("v.Var1","Demo Value from Component's Controller")
        var data = {'name' : 'Test name',
                    'email' : 'test@teptest.com'};
        component.set("v.jsObject", data);
        
        component.set("v.userData",
                      {
                          'myString1' : 'StringValue',
                          'myInteger1' : 2023
                      })
	}
})