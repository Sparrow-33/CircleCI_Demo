public class ParkServiceMock implements WebServiceMock  {
    
    public void doInvoke(
       Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
               
               ParkService.byCountryResponse res = 
                   new ParkService.byCountryResponse();
               
              res.return_x = new List<String>{'Hamburg Wadden Sea National Park', 'Hainich National Park', 'Bavarian Forest National Park'};
                  
                response.put('response_x', res);
           }
}