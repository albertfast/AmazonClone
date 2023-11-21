trigger Account2Trigger on Account (after update) {
    if (trigger.isAfter && trigger.isUpdate){
        Set<Id> accIds = new Set<Id>();
        List<Contact> conList = new List<Contact>();
        for (Account acc : trigger.new) {
            if (((acc.BillingCity!=trigger.oldMap.get(acc.Id).BillingCity) ||
                (acc.BillingCountry!=trigger.oldMap.get(acc.Id).BillingCountry) ||
                (acc.BillingState!=trigger.oldMap.get(acc.Id).BillingState) ||
                (acc.BillingStreet!=trigger.oldMap.get(acc.Id).BillingStreet) ||
                (acc.BillingPostalCode!=trigger.oldMap.get(acc.Id).BillingPostalCode)) &&
                trigger.oldMap != null) {
                accIds.add(acc.Id);
            }
        } 
        for (Account acc : [SELECT Id, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, (Select Id From Contacts) FROM Account WHERE Id IN: accIds]) {
            if (acc.Contacts != null) {
                for (Contact con : acc.Contacts) {
                    con.MailingCity=acc.BillingCity;
                    con.MailingCountry=acc.BillingCountry;
                    con.MailingState= acc.BillingState;
                    con.MailingStreet= acc.BillingStreet;
                    con.MailingPostalCode= acc.BillingPostalCode;
                    conList.add(con);
                }
            }
        }
        if (!conList.isEmpty()) {
            update conList;
        }
    }
}