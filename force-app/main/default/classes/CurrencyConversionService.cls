public class CurrencyConversionService {
     @InvocableMethod(label='Convert USD to MAD' description='USD to MAD dec')
    public static List<Double> convertUSDToMAD(List<Double> amount) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://apilayer.net/api/live?access_key=6452fd6e6bcf4b2c3bb6768508d5449c&currencies=MAD&source=USD&format=1');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        Map<String, Object> quotesMap = (Map<String, Object>)responseMap.get('quotes');
        Decimal exchangeRate = (Double)quotesMap.get('USDMAD');
        
        List<Double> amounts = new List<Double>();
        amounts.add( amount.get(0) * exchangeRate);
        return amounts;
    }
    
    public static Double getUDSMADExchangeRate() {
         HttpRequest req = new HttpRequest();
        req.setEndpoint('http://apilayer.net/api/live?access_key=6452fd6e6bcf4b2c3bb6768508d5449c&currencies=MAD&source=USD&format=1');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        Map<String, Object> quotesMap = (Map<String, Object>)responseMap.get('quotes');
        return (Double)quotesMap.get('USDMAD');
    }
}