public class DataSet {
    
    public Static String getCalloutResponceContents(String url) {
        
        Http h = new Http();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        
        HttpResponse res = h.send(req);
        return res.getBody();
        
    }

}