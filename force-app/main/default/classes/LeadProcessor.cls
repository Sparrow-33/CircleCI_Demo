public class LeadProcessor implements Database.Batchable<sObject> {
           
           public Database.QueryLocator start(Database.BatchableContext bc) {
               
            return Database.getQueryLocator(
                    'SELECT ID, ' +
                    'LeadSource ' +
                    'FROM Lead ' +
                    'WHERE LeadSource = \'Dreamforce\''
                );
           } 
           
           public void execute(Database.BatchableContext bc, List<Lead> leadList) {
               
               for(Lead ld : leadList) {
                   ld.LeadSource = 'Web';
               }
               
               update leadList;
           } 
           
           public void finish(Database.BatchableContext bc) {
               AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
                                    JobItemsProcessed,
                                    TotalJobItems, CreatedBy.Name
                                   FROM AsyncApexJob
                                   WHERE Id = :bc.getJobId()
                                  ];
               System.debug('ABOUT LEAD PROCESSOR BATCH ');
           }

}