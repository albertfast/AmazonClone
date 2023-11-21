/*Apply validation using adderror() method in trigger. while creation of opp amount is null then throw an error message */
trigger Opportunity2Trigger on Opportunity (before insert) {
    if (trigger.isBefore && trigger.isInsert) {
        for (Opportunity opp : trigger.new) {
            if (opp.Amount == null) {
                opp.addError('You can not create opportunity without amount!');
            }
        }
    }
}