/*When Account active field is updated from yes to no then check all opp associated with the account. 
  Update all opp stage field to close lost if stage not equal to close won */
trigger Account3Trigger on Account (after update) {
    if (trigger.isAfter && trigger.isUpdate) {
        Set<Id> accIds = new Set<Id>();
        List<Opportunity> oppList = new List<Opportunity>();
        for (Account acc : Trigger.new) {
            if (acc.Active__c == 'No' && acc.Active__c != Trigger.oldMap.get(acc.Id).Active__c ) {
                accIds.add(acc.Id);
            }
        }
        for (Account acc : [SELECT Id, Active__c, (SELECT Id,StageName FROM Opportunities) FROM ACCOUNT WHERE Id IN: accIds]) {
            if (acc.Opportunities != null) {
               for (Opportunity opp : acc.Opportunities) {
                if (opp.StageName !='Closed Won' && opp.StageName != 'Closed Lost') {
                    opp.StageName = 'Closed Lost';
                    oppList.add(opp);
                }
               } 
            }
        }
        if (!oppList.isEmpty()) {
            update oppList;
        }
    }
}