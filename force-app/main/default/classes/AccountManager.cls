@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {


    @HttpGet
    global static Account getAccount() {

      RestRequest request = RestContext.request;  
      String accId = request.requestURI.substringBetween('/Accounts/', '/contacts');

      List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Id = :accId];

      if (accounts.isEmpty()) {
        return null;
      }
    
      return accounts[0];
   
      
    } 
   
}