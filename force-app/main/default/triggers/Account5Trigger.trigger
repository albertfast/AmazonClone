/*Write a trigger on account and check only system administrator profile users shold be able to delete an account */
trigger Account5Trigger on Account (before delete) {
    if (Trigger.isBefore && Trigger.isDelete) {
        Profile p = [SELECT Id, Name FROM Profile WHERE Name = 'System Administrator'];
        for (Account acc : trigger.old) {
          if (UserInfo.getProfileId()!=p.Id) {
            acc.addError('You dont have permission to delete an Account, please contact System Administrator.');
          }  
        }
    }
}