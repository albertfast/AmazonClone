// We have a checkbox with Primary Contact on Contact object. Each account can have just one Primary Contact,
//When contact inserting or updating check this checkbox, if account doesn't have any primary contact allow save to database.
public with sharing class triggerHelper {
     public static void trgMethod(List<Contact> conList, Map<Id,Contact> oldMap) {
        Set<Id> parentIds = new Set<Id>();
        Map<Id,Integer> conMap = new Map<Id,Integer>();
        if (!conList.isEmpty()) {
            for (Contact con : conList) {
                if (oldMap != null) {
                    Contact oldCon = oldMap.get(con.Id);

                    if (oldCon.AccountId != con.AccountId) {
                        parentIds.add(oldCon.AccountId);
                        parentIds.add(con.AccountId);
                    }
                    else {
                        parentIds.add(con.AccountId);
                    }
                }
                else {
                    parentIds.add(con.AccountId);
                }
            }
        }

        if (!parentIds.isEmpty()) {
            List<Contact> contactList = [SELECT Id,AccountId,Primary_Contact__c	FROM Contact 
                                        WHERE AccountId IN : parentIds AND Primary_Contact__c = true];
             if (!contactList.isEmpty()) {
                for (Contact objCon : contactList) {
                    conMap.put(objCon.AccountId, contactList.size());
                }

                for (Contact errorCon : conList) {
                    if (errorCon.Primary_Contact__c == true && conMap.containsKey(errorCon.AccountId)
                        && conMap.get(errorCon.AccountId) > 0) {
                        errorCon.addError('This account cannot have more than one Primary Contact');
                    }
                }
             }                           
        }
    }
}

