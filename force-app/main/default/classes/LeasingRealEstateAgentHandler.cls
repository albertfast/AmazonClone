public with sharing class LeasingRealEstateAgentHandler {

    public static void checkDuplicateAgentOnLeasing(List<Leasing_Real_Estate_Agent__c> leasingRealEstateAgent) {
        Map<String,Leasing_Real_Estate_Agent__c> leasingRealEstateMap = new Map<String,Leasing_Real_Estate_Agent__c>();
        Set<Id> leasingIds = new Set<Id>();
        Set<Id> realEstateAgentIds = new Set<Id>();

        for (Leasing_Real_Estate_Agent__c lr : leasingRealEstateAgent) {
            String uniqueKey = String.valueOf(lr.Leasing__c) + String.valueOf(lr.Real_Estate_Agent__c);
            leasingRealEstateMap.put(uniqueKey, lr);

            leasingIds.add(lr.Leasing__c);
            realEstateAgentIds.add(lr.Real_Estate_Agent__c);
        }

        List<Leasing_Real_Estate_Agent__c> onSystemRecords = [ SELECT Id, Leasing__c, Real_Estate_Agent__c
                                                               FROM Leasing_Real_Estate_Agent__c
                                                               WHERE Leasing__c IN: leasingIds
                                                               AND Real_Estate_Agent__c IN: realEstateAgentIds];
        for (Leasing_Real_Estate_Agent__c sys : onSystemRecords) {
            String uniqueKey = String.valueOf(sys.Leasing__c) + String.valueOf(sys.Real_Estate_Agent__c);
            Leasing_Real_Estate_Agent__c checkingObject = leasingRealEstateMap.get(uniqueKey);
            if (checkingObject == null) continue;
            //if(leasingRealEstateMap.keySet().contains(uniqueKey)) 

            checkingObject.addError('Found a duplicate Leasing - Real Estate Agent Record on the system' + String.valueOf(sys.Id));
        }                                                       
    }
}



