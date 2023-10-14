public class AboutAccounts {



        @AuraEnabled
        public static List<Account>  getActiveAccounts(){
            try {
                return [SELECT Name, Industry,Phone  FROM Account WHERE Active__c = 'Yes' LIMIT 10];

            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
      
        
    
        public void deactivateAccount() {
                    Id accountId = ApexPages.currentPage().getParameters().get('accountId');
                    Account acc = [SELECT Id, Name, Active__c FROM Account WHERE Id = :accountId];
                    acc.Active__c = 'No';
            
                    update acc;
                }

        public List<Account> modifiedAccounts { get; set; }

        public void deactivateAccounts() {
            update modifiedAccounts;
            }


      public void insertMassAccount() {
        List<Account> accToInsert = new List<Account>();

        for(Integer i = 0; i < 200; i++) {
            Account acc = new Account(Name = 'acc '+ i+1);
            accToInsert.add(acc);
        }

        List<Database.saveResult> result = Database.insert(accToInsert, false);

        for (Database.saveResult res : result) {
            if (res.isSuccess()) {

                System.debug('Account has been inserted with success '+ res.getId());
                
            } else {

                for(Database.Error err : res.getErrors()) {
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                }
            }
        }
      }
        

}