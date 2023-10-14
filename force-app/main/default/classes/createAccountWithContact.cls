@RestResource(urlMapping='/Account/*')
global with sharing class createAccountWithContact {
    
    @HttpPost
    global static void doPost(String name) {
        
        Account acc = new Account();
        acc.Name = name;
        
        insert acc;
        System.debug('The accout ID '+ acc.id);
        Contact cnct = new Contact(	AccountId = acc.Id);
        insert cnct;
        System.debug('The contact ID '+ cnct.id);

       
    }

}