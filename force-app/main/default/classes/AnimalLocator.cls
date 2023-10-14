public class AnimalLocator {
    
    public Static String getAnimalNameById(Integer anId) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+anId);
        request.setMethod('GET');
        
        response = http.send(request);
        
   //     if(response.getStatusCode() == 200) {
           Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
           Map<String, Object> animal = (Map<String, Object>)result.get('animal');
           return (String) animal.get('name');
       // } else {
      //      System.debug('An error occured  '+response.getStatus());
   //     }
        
    }

}