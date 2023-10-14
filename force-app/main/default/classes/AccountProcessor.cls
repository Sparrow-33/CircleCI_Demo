public with sharing class AccountProcessor {

    @future
    public static void countContacts(List<Id> accIds) {

        List<Account> numOfAcc = [SELECT Id, Number_Of_Contacts__c,
                                  (SELECT Id FROM Contacts)
                                  FROM Account
                                  WHERE Id IN :accIds
                                  ];

        for(Account acc : numOfAcc) {
             acc.Number_Of_Contacts__c = acc.Contacts.size();
        }


        update numOfAcc;


    }
    
}