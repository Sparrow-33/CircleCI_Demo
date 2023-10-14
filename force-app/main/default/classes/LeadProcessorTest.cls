@isTest
private class LeadProcessorTest {

    @testSetup
    static void setup() {
        List<Lead> leads = new List<Lead>();
        
        for(Integer i = 0; i < 200; i++) {
            leads.add(
              new Lead(FirstName = 'test',LastName = 'leadProcessor '+i,Company = 'leadProcessor '+i, LeadSource = 'Dreamforce')
            );
        }
        
        insert leads;
    }
    
    @isTest
    static void test() {
        Test.startTest();
        
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        
        Test.stopTest();
        System.debug('This is leads list size  '+[SELECT Id FROM Lead WHERE LeadSource = 'Dreamforce'].size());
        System.assert([SELECT Id FROM Lead WHERE LeadSource = 'Dreamforce'].size() == 0);
    }
}