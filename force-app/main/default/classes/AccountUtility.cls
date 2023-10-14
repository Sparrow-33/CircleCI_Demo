global class AccountUtility implements Database.Batchable<sObject>  {
    
  Set<String> uniqueCities = new Set<String>();

 global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, Temperature__c,BillingCity  FROM Account';
        return Database.getQueryLocator(query);
    }
     
    global void execute(Database.BatchableContext BC, List<Account> accList) {
        
         Map<String, Double> cityTemperatureMap = new Map<String, Double>();
        
         for (Account acc : accList) {
            if (acc.BillingCity != null) {
                //uniqueCities.add(acc.BillingCity);
               cityTemperatureMap.put(acc.BillingCity, null);
            }
        }
        
        for(String city : cityTemperatureMap.keySet()) {
           Double temperature = OpenWeather.getWeatherData(city);
           cityTemperatureMap.put(city, temperature);
            }
        
      for (Account acc : accList) {
        if (acc.BillingCity != null) {
            Double temperature = cityTemperatureMap.get(acc.BillingCity);
            if (temperature != null) {
                acc.Temperature__c = temperature;
            } else {
                System.debug('BATCH ACCOUNT UTIL ERR');
            }
        }
    }
    
    // Update the modified Account records
    update accList;
         
    }  
     
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
    }
}