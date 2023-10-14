public with sharing class AboutContacts {
    public AboutContacts() {

    }

    @AuraEnabled
    public static List<Contact> getContacts(){
        try {

            return [SELECT Name FROM Contact LIMIT 10];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}