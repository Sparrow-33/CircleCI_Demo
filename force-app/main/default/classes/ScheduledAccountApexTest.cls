@isTest
public class ScheduledAccountApexTest {
    
     @isTest
    static void testScheduledJob() {
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.BillingCity = 'Youssoufia';
        insert acc;
        
        Test.startTest();
        String cronExp = '0 0 0 1 1 ?';
        System.schedule('Test Scheduled Job', cronExp, new ScheduledAccountApex());
        Test.stopTest();
        
        Account updatedAcc = [SELECT Ecole__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Youcode', updatedAcc.Ecole__c);
    }

}