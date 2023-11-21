trigger ContactTrigger on Contact (before insert, before update) {
    if (Trigger.isBefore && Trigger.isUpdate) {
        triggerHelper.trgMethod(trigger.new, trigger.oldMap);
        ContactTriggerHandler.updatePhone(trigger.new);
    }
    else if (trigger.isBefore && trigger.isInsert) {
        triggerHelper.trgMethod(trigger.new, null);
    }
}

