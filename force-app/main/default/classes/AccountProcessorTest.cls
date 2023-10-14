@isTest
private with sharing class AccountProcessorTest {
  
   @isTest 
  private static void testCountContacts() {

    List<Id> accIdToUpdate = new List<Id>();

    Account testAccount = new Account(Name ='future test account');
    insert testAccount;

    Contact testContact = new Contact(Lastname ='testContact', accountId = testAccount.Id);
    insert testContact;

    accIdToUpdate.add(testAccount.Id);

    Test.startTest();
     
       AccountProcessor.countContacts(accIdToUpdate);

    Test.stopTest();


    testAccount = [SELECT Number_Of_Contacts__c FROM Account WHERE Id = :testAccount.Id ];
    System.assertEquals(1,testAccount.Number_Of_Contacts__c);

  
  }

}