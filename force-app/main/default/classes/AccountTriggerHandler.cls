public class AccountTriggerHandler {
    public static void updateContactHomePhone(List<Account> newAccounts, Map<Id, Account> oldAccountMap) {
        Map<Id,Account> accMap = new Map<Id,Account>();
        List<Contact> conList = new List<Contact>();
        for (Account acc : newAccounts) {
            if (acc.Phone != null && acc.phone != oldAccountMap.get(acc.id).Phone && oldAccountMap != null) {
                accMap.put(acc.Id, acc);
            }
        }

        for (Contact con : [SELECT Id, HomePhone, AccountId FROM Contact WHERE AccountId IN: accMap.keySet()]) {
            if (accMap.containsKey(con.AccountId)) {
                con.HomePhone = accMap.get(con.AccountId).Phone;
                conList.add(con);
            }
        }
        if (!conList.isEmpty()) {
            update conlist;
        }
    }
    //Automatically close Opportunities with Probability Greater than 70% when 'Close all Opps' checkbox is checked on Account 
    public static void closeOpportunity(List<Account> accList, Map<Id, Account> oldMap) {
        Set<Id> accIds = new Set<Id>();
        if (!accList.isEmpty()) {
            for (Account ac : accList) {
                if (ac.Close_all_Opps__c == true && oldMap.containsKey(ac.Id) && oldMap.get(ac.Id).Close_all_Opps__c == false) {
                    accIds.add(ac.Id);
                }
            }
        }
        if (!accIds.isEmpty()) {
            List<Opportunity> oppList = [SELECT Id,AccountId,StageName,Probability FROM Opportunity
                                        WHERE AccountId IN : accIds AND StageName != 'Closed Won' AND Probability >=70];
            List<Opportunity> listToUpdate = new List<Opportunity>();                           
        if (!oppList.isEmpty()) {
            for (Opportunity opp : oppList) {
                opp.StageName = 'Closed Won';
                opp.CloseDate = date.today();
                listToUpdate.add(opp);
            }
        }  

        if (!listToUpdate.isEmpty()) {
            update listToUpdate;
        }
        }
    }
}