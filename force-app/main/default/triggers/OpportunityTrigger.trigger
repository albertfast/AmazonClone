trigger OpportunityTrigger on Opportunity (After insert, After update, After delete, 
After undelete, before insert, before update) {
    //Trigger to find sum of all related Opportunities Amount of an Account
    Set<Id> accIds = new Set<Id>();
    if (trigger.isAfter && (trigger.isInsert || trigger.isUndelete)) {
        if (!trigger.new.isEmpty()) {
            for (Opportunity op : trigger.new) {
                if (op.AccountId != null) {
                    accIds.add(op.AccountId);
                }
            }
        }
    }
    if (trigger.isAfter && trigger.isUpdate) {
        if (!trigger.new.isEmpty()){
            for (Opportunity op : trigger.new){
                if (op.AccountId != trigger.oldMap.get(op.Id).AccountId) {
                    accIds.add(op.AccountId);
                    accIds.add(trigger.oldMap.get(op.Id).AccountId);
                }
                else {
                    accIds.add(op.AccountId);
                }
            }
        }
    }
    if (trigger.isAfter && trigger.isDelete) {
        if (!trigger.old.isEmpty()) {
            for (Opportunity op : trigger.old){
                if (op.AccountId != null){
                    accIds.add(op.AccountId);
                }
            }
        }
    }
    if (!accIds.isEmpty()) {
        List<AggregateResult> aggrList = [ SELECT AccountId ids, sum(Amount) totalAm 
                                           FROM Opportunity
                                           WHERE AccountId IN : accIds group by AccountId];
        Map<Id,Account> accMap = new Map<Id,Account>();                                   
        if (!aggrList.isEmpty()) {
            for (AggregateResult aggr : aggrList) {
                Account acc = new Account();
                acc.Id = (Id)aggr.get('ids');
                acc.Total_Opp_Amount__c = (Decimal)aggr.get('totalAm');
                accMap.put(acc.Id, acc);
            }
        }  
        else{
            for (Id accId : accIds) {
                Account acc = new Account();
                acc.Id = accId;
                acc.Total_Opp_Amount__c = 0;
                accMap.put(acc.Id, acc);
            }
        }
        
        if(!accMap.isEmpty()){
           update accMap.values(); 
        }
    }
}

































/*
    if (Trigger.isAfter && Trigger.isUpdate) {
        OpportunityTriggerHandler.updateAccountandContactDescription(Trigger.new, Trigger.oldMap);
    } 
    if (trigger.isBefore && trigger.isUpdate) {
        OpportunityTriggerHandler.updateType(trigger.new, trigger.oldMap);
    
    }  */
