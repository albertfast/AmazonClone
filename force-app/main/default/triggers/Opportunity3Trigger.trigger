/*When an opp is updates to closed lost and closed lost reason field is not populated then throw validation error
thet 'Please populate closed lost reason' on opportunity */
trigger Opportunity3Trigger on Opportunity (before update) {
    if (Trigger.isBefore && trigger.isUpdate) {
        for (Opportunity opp : trigger.new) {
            if (opp.StageName == 'Closed Lost' && opp.Closed_Lost_Reason__c ==null) {
                opp.addError('Please populate closed lost reason');
            }
        }
    }
}