@IsTest
private class AccountUtilityTest {
    
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 200; i++) {
            Account acc = new Account(Name = 'Test Account ' + i, BillingCity = 'Test City ' + i);
            accounts.add(acc);
        }
        insert accounts;
    }
    
    @IsTest
    static void testAccountUtilityBatch() {

        Test.setMock(HttpCalloutMock.class, new OpenWeatherMock());
        
        Test.startTest();
        
        AccountUtility batch = new AccountUtility();
        Database.executeBatch(batch);
        
        Test.stopTest();
        
        List<Account> updatedAccounts = [SELECT Id, Temperature__c FROM Account];
        System.assertEquals(200, updatedAccounts.size());
        for (Account acc : updatedAccounts) {
            System.assertNotEquals(null, acc.Temperature__c);
        }
    }
    
   
}