@isTest
  public class OpenWeatherMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            res.setBody('{"temp": 25.0}');
            return res;
        }
    }