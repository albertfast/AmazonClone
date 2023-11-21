/* WHEN aCCOUNT BILLING ADDRESS IS UPDATE, UPDATE TO CONTACT MAILING ADDRESS */
trigger Account1Trigger on Account (after update){
    if (trigger.isAfter && trigger.isUpdate) {
        Map<Id,Account> accMap = new Map<Id,Account>();
        List<Contact> conList = new List<Contact>();
        for (Account acc : trigger.new) {
            if (((acc.BillingCity!=trigger.oldMap.get(acc.Id).BillingCity) ||
                (acc.BillingCountry!=trigger.oldMap.get(acc.Id).BillingCountry) ||
                (acc.BillingState!=trigger.oldMap.get(acc.Id).BillingState) ||
                (acc.BillingStreet!=trigger.oldMap.get(acc.Id).BillingStreet) ||
                (acc.BillingPostalCode!=trigger.oldMap.get(acc.Id).BillingPostalCode)) &&
                trigger.oldMap != null) {
                accMap.put(acc.Id, acc);
            }
        }
        for (Contact con : [SELECT Id,AccountId FROM Contact WHERE AccountId IN: accMap.keySet()]){
            if (accMap.containsKey(con.AccountId)) {
                con.MailingCity=accMap.get(con.AccountId).BillingCity;
                con.MailingCountry=accMap.get(con.AccountId).BillingCountry;
                con.MailingState=accMap.get(con.AccountId).BillingState;
                con.MailingStreet=accMap.get(con.AccountId).BillingStreet;
                con.MailingPostalCode=accMap.get(con.AccountId).BillingPostalCode;
                conList.add(con);
            }
        }
        if (!conList.isEmpty()) {
            update conList;
        }
    }
}