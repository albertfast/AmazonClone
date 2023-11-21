public with sharing class OpportunityTriggerHandler {
    //if Opportunity have a account, they can not update Opportunity Type field.
    public static void updateType(List<Opportunity> newOpp, Map<Id,Opportunity> oldOpps) {
        for (Opportunity opp : newOpp) {
            Opportunity oldOpp = oldOpps.get(opp.Id);
            if (oldOpp != null && opp.AccountId != null && opp.Type != oldOpp.Type) {
                opp.addError('You cannot update Type field, if Opportunity have an account');
            }
        }
    }

       //If opportunity amount uptaded to more than $10000 and it will populate to account and contact description, this opp amount changed to .
    public static void updateAccountandContactDescription(List<Opportunity> newOpp, Map<Id,Opportunity> oldOpportunityMap) {
        Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>();
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        for (Opportunity opp : newOpp) {
            if (opp.Amount != null  && opp.Amount > 10000 && opp.Amount != oldOpportunityMap.get(opp.Id).Amount && oldOpportunityMap !=null ) {
                oppMap.put(opp.AccountId, opp);
            }
        }

        for (Account acc : [SELECT Id, Description FROM Account WHERE Id IN :oppMap.keySet()]) {
            Opportunity relatedOpp = oppMap.get(acc.Id);
            acc.Description = 'This opportunity ' + relatedOpp.Name + ' old amount is ' + oldOpportunityMap.get(relatedOpp.Id).Amount + ' changed to ' + relatedOpp.Amount;
            accList.add(acc);
        }
        for (Contact con : [SELECT Id, Description, AccountId FROM Contact WHERE AccountId IN :oppMap.keySet()]) {
            Opportunity relatedOpp = oppMap.get(con.AccountId);
            con.Description =  'This opportunity ' + relatedOpp.Name + ' old amount is ' + oldOpportunityMap.get(relatedOpp.Id).Amount + ' changed to ' + relatedOpp.Amount;
            conList.add(con);
        }
        if (!accList.isEmpty()) {
            update accList;
        }
        if (!conList.isEmpty()) {
            update conlist;
        }
    }

    
}


   

/*

//Trigger to find sum of all related Opportunities Amount of an Account
    private Map<Id, Opportunity> oldMap;
    private Map<Id, Opportunity> newMap;
    private List<Opportunity> oldList;
    private List<Opportunity> newList;

    public OpportunityTriggerHandler(Map<Id, Opportunity> oldMap, Map<Id, Opportunity> newMap, List<Opportunity> oldList, List<Opportunity> newList) {
        this.oldMap = oldMap;
        this.newMap = newMap;
        this.oldList = oldList;
        this.newList = newList;
    }

    public void afterInsertUpdate() {
        Set<Id> accIds = new Set<Id>();
        if (!newList.isEmpty()) {
            for (Opportunity op : newList) {
                if (op.AccountId != null) {
                    accIds.add(op.AccountId);
                }
            }
        }

        if (!newList.isEmpty()){
            for (Opportunity op : newList){
                if (op.AccountId != oldMap.get(op.Id).AccountId) {
                    accIds.add(op.AccountId);
                    accIds.add(oldMap.get(op.Id).AccountId);
                }
                else {
                    accIds.add(op.AccountId);
                }
            }
        }

        updateAccount(accIds);
    }

    public void afterDelete() {
        Set<Id> accIds = new Set<Id>();
        if (!oldList.isEmpty()) {
            for (Opportunity op : oldList){
                if (op.AccountId != null){
                    accIds.add(op.AccountId);
                }
            }
        }

        updateAccount(accIds);
    }

    private void updateAccount(Set<Id> accIds) {
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

*/