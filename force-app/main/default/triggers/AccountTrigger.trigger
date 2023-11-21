trigger AccountTrigger on Account (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        AccountTriggerHandler.updateContactHomePhone(Trigger.new, Trigger.oldMap);
        AccountTriggerHandler.closeOpportunity(Trigger.new, Trigger.oldMap);
    }
}