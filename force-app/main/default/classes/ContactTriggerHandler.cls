//if contact have a account, they can not update contact phone field.
public with sharing class ContactTriggerHandler {
   
    public static void updatePhone(List<Contact> conlist) {
        Map<Id, Contact> conMap = new Map<Id, Contact>();
        Set<Id> conIds = new Set<Id>();
        
        for (Contact con : conlist) {
            conIds.add(con.AccountId);       
            }

            List<Contact> cnList = [SELECT Id, Phone,AccountId FROM Contact WHERE AccountId IN: conIds ];
            for (Contact cn : cnList) {
                conMap.put(cn.Id, cn);
            }
            for (Contact con : conlist){
                if (conMap.containsKey(con.Id) && con.Phone != conMap.get(con.id).Phone) {
                    con.addError('You cannot update phone field, if contact have an account');
                }
            }
    }
}

/*
public with sharing class ContactTriggerHandler {
    public static void updatePhone(List<Contact> newContacts, Map<Id, Contact> oldContacts) {
        for (Contact con : newContacts) {
            Contact oldCon = oldContacts.get(con.Id);
            if (oldCon != null && con.AccountId != null && con.Phone != oldCon.Phone) {
                con.addError('You cannot update phone field, if contact have an account');
            }
        }
    }
}


*/

