global class UpdateAccountCityTemperature implements Schedulable {
    
        global void execute(SchedulableContext ctx) {
            
            List<Account> accountsToUpdate = new List<Account>();
            
            List<Account> accountsWithBillingCity = [SELECT BillingCity, Temperature__c FROM Account WHERE BillingCity != NULL];
            
            Set<String> distinctCities = new Set<String>();
            
            for(Account acc: accountsWithBillingCity) {
                distinctCities.add(acc.BillingCity);
            }
            
            for(String city: distinctCities) {
                String url = 'https://api.openweathermap.org/data/2.5/weather?q=' + EncodingUtil.urlEncode(city, 'UTF-8') + 'd0b2c2e22702a48bddeeda5dc1c100de';
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                
                request.setEndpoint(url);
                request.setMethod('GET');
                
                HttpResponse response = http.send(request);
                
                if(response.getStatusCode() == 200) {
                   Map<String, Object> jsonResponse = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                   Double temperature = (Double)((Map<String, Object>)jsonResponse.get('main')).get('temp');
                    
                    for(Account acc :accountsWithBillingCity) {
                        if(acc.BillingCity == city) {
                            acc.Temperature__c = temperature;
                            accountsToUpdate.add(acc);
                        }
                    }
                }
            }
            
            if(accountsToUpdate.size() > 0) {
                update accountsToUpdate;
            }

        }
}