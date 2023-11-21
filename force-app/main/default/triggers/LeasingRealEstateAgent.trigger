trigger LeasingRealEstateAgent on Leasing_Real_Estate_Agent__c (before insert) {
    if (trigger.isBefore) {
        if (trigger.isInsert || trigger.isUpdate) {
            LeasingRealEstateAgentHandler.checkDuplicateAgentOnLeasing(trigger.new);
        }
    }
}