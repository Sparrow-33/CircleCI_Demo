public class PropertyUtility {

    public static void newListedProperties() {
        
        List<Property__c> newPropList = new List<Property__c>();
        String propEmail;
        newPropList = [
            SELECT 
            Name,
            Days_On_Market__c,
            Broker__r.Email__c
            FROM
            Property__c
            WHERE
            Days_On_Market__c <= 30            
        ];
        
        for(Property__c prpt : newPropList) {
           propEmail = prpt.Name +' : '+prpt.Broker__r.Email__c;
           System.debug(propEmail);
        }
        
    }
    
}