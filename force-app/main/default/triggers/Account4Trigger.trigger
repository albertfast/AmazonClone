/*Prevent Account record from being edited if the record is created 7 days back*/
trigger Account4Trigger on Account (before update) {
    if (Trigger.isBefore && Trigger.isUpdate) {
        for (Account acc : trigger.new) {
            if (acc.CreatedDate<System.today()-6) {
                acc.addError('You can not update account created 7 days back');
            }
        }
    }
}