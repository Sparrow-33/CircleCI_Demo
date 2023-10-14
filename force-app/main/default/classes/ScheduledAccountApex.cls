global class ScheduledAccountApex implements Schedulable {
    global void execute(SchedulableContext sc) {
        List<Account> accs = [SELECT Id,billingCity FROM Account WHERE billingCity = 'Youssoufia' AND Ecole__c = NULL];
        
        for (Account acc : accs) {
            acc.Ecole__c = 'Youcode';
        }
        update accs;
    }
}