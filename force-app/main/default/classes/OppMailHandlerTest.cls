@IsTest
public class OppMailHandlerTest {
    @IsTest
    static void testSendEmailOnOppUpdate() {
        // Create test data
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Closed Won',
            OwnerId = UserInfo.getUserId(),
            CloseDate = DATE.today()
        );
        insert opp;

        EmailTemplate template = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'oppUpdate' LIMIT 1];

        Test.startTest();
        List<Opportunity> oppList = new List<Opportunity>();
        oppList.add(opp);
        OppMailHandler.sendEmailOnOppUpdate(oppList);
        Test.stopTest();

       
    }
}