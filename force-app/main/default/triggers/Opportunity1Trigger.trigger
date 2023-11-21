/*When a opp stage field is changed, create a task record on opp and assign it to logged in user/ opp owner / any user */
trigger Opportunity1Trigger on Opportunity (after update) {
   if (trigger.isAfter && trigger.isUpdate) {
        List<Task> taskList = new List<Task>();
        for (Opportunity opp : trigger.new) {
            if (opp.StageName != trigger.oldMap.get(opp.Id).StageName) {
                Task task1 = new Task();
                task1.Status = 'Not Started';
                task1.Subject = 'Call';
                task1.Priority = 'High';
                task1.WhatId = opp.Id;
                task1.OwnerId = UserInfo.getUserId();
                taskList.add(task1);
            }
        }
        if (!taskList.isEmpty()) {
            insert taskList;
        }
    } 
    
}