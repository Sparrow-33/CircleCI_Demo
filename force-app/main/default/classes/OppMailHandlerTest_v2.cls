@isTest
public class OppMailHandlerTest_v2 {
    @isTest
    static void testSendEmailOnOppUpdate() {
        // Create test data
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opportunity';
        opp.StageName = 'Closed Won';
        opp.CloseDate = DATE.today();
        insert opp;

        // Create OpportunityLineItem
        OpportunityLineItem oli = new OpportunityLineItem();
        oli.OpportunityId = opp.Id;
        oli.Product2Id = Test.getStandardPricebookId();
        oli.Quantity = 1;
        oli.UnitPrice = 100;
        insert oli;

        // Create a user for testing
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        User user = new User();
        user.FirstName = 'Test';
        user.LastName = 'User';
        user.Email = 'testuser@test.com';
        user.Username = 'testuser@test.com';
        user.Alias = 'tuser';
        user.CommunityNickname = 'testuser';
        user.ProfileId = profile.Id;
        user.EmailEncodingKey = 'UTF-8';
        user.LanguageLocaleKey = 'en_US';
        user.LocaleSidKey = 'en_US';
        user.TimeZoneSidKey = 'America/Los_Angeles';
        insert user;

        // Assign opportunity to the user
        opp.OwnerId = user.Id;
        update opp;

        // Create oldOppsMap
        Map<Id, Opportunity> oldOppsMap = new Map<Id, Opportunity>();
        oldOppsMap.put(opp.Id, new Opportunity(StageName = 'Prospecting'));

        // Call the method to test
        Test.startTest();
        OppMailHandler.sendEmailOnOppUpdate(new List<Opportunity>{ opp }, oldOppsMap);
        Test.stopTest();

        // Verify the email sent
       // List<Messaging.SingleEmailMessage> sentEmails = [SELECT Id, ToAddress FROM Messaging.SingleEmailMessage];
     //   System.assertEquals(1, sentEmails.size());
   //     System.assertEquals(user.Email, sentEmails[0].getToAddresses()[0]);
    }
}