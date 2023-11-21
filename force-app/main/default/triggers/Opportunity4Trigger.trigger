/*If an opportunity is closed then, no one should be able to delete it except the user having a system administrator profile*/
trigger Opportunity4Trigger on Opportunity (before delete) {
    if (Trigger.isBefore && Trigger.isDelete) {
        Profile p = [SELECT Id, Name FROM Profile WHERE Name = 'System Administrator'];
        for (Opportunity opp : Trigger.old) {
            if (opp.StageName == 'Closed Lost' || opp.StageName == 'Closed Won' ) {
                if (UserInfo.getProfileId()!=p.Id) {
                    opp.addError('You dont have permission to delete an Opportunity, please contact System Administrator.');
                }
            }
        }
    }
}