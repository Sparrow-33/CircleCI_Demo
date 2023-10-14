@isTest
public class BatchApexExampleTest {
    
    @isTest
    static void testBatchApexExample() {
        
        List<Account> accList = new List<Account>();
        for (Integer i = 0; i < 100; i++) {
            accList.add(new Account(Name='Test Account ' + i));
        }
        insert accList;
        
         BatchApexExample batchJob = new BatchApexExample();
         Id batchJobId = Database.executeBatch(batchJob);
        
        AsyncApexJob jobInfo = [SELECT Id, Status, NumberOfErrors FROM AsyncApexJob WHERE Id = :batchJobId];
        while(jobInfo.Status == 'Processing' || jobInfo.Status == 'Preparing') {
            jobInfo = [SELECT Id, Status, NumberOfErrors FROM AsyncApexJob WHERE Id = :batchJobId];
            System.debug('Batch job status: ' + jobInfo.Status);
            System.assertEquals(null, jobInfo.NumberOfErrors, 'Errors occurred while processing the batch job');
            System.assertNotEquals('Aborted', jobInfo.Status, 'The batch job was aborted');
            System.assertNotEquals('Failed', jobInfo.Status, 'The batch job failed');
            System.assertNotEquals('Completed with failures', jobInfo.Status, 'The batch job completed with failures');
            System.assertNotEquals('Completed with no failures', jobInfo.Status, 'The batch job completed with no failures');
            Test.stopTest();
        }
    }
}