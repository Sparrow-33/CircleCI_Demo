@isTest
public class AnimalLocatorMock implements HttpCalloutMock {
  
   public String name;
    public  HTTPResponse respond(HTTPRequest request) {
           HTTPResponse response = new HTTPResponse();
        response.setStatusCode(200);
        response.setBody('{"animal":{"name":"chicken"}}');
        
           Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
           Map<String, Object> animal = (Map<String, Object>)result.get('animal');
          name = (String)animal.get('name');
     
        return response;
    } 
    
}