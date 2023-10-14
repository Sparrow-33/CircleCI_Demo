@isTest
public class UpdateAccountCityTemperatureTest {

    @isTest
    static void testScheduledJob() {
        // Create a test account
        Account testAccount = new Account(Name = 'Test Account', BillingCity = 'San Francisco', Temperature__c = null);
        insert testAccount;
        
        // Create a mock HTTP response
       String url = 'https://api.openweathermap.org/data/2.5/weather?q=' + EncodingUtil.urlEncode(testAccount.BillingCity, 'UTF-8') + '&appid=d0b2c2e22702a48bddeeda5dc1c100de';
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                
                request.setEndpoint(url);
                request.setMethod('GET');
                
                HttpResponse response = http.send(request);
        
        // Schedule the job
        String jobId = System.schedule('Test Job', '0 0 0 * * ?', new UpdateAccountCityTemperature());
        
        // Wait for the scheduled job to complete
        Test.stopTest();
        CronTrigger cronTrigger = [SELECT Id, CronJobDetail.Name FROM CronTrigger WHERE Id = :jobId];
        System.assertEquals('Test Job', cronTrigger.CronJobDetail.Name);
        System.assertEquals('Completed', cronTrigger.State);
        Test.startTest();
        
        // Verify that the temperature was updated
        testAccount = [SELECT Temperature__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(20.0, testAccount.Temperature__c, 'Temperature not updated');
    }
}