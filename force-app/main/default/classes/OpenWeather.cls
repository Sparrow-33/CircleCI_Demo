public class OpenWeather {
    public static Double getWeatherData(String city) {
        // Construct the API request URL
        String apiKey = 'd0b2c2e22702a48bddeeda5dc1c100de';
        String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=' + EncodingUtil.urlEncode(city, 'UTF-8') + '&appid=' + apiKey;

        HttpRequest request = new HttpRequest();
        request.setEndpoint(apiUrl);
        request.setMethod('GET');

        Http http = new Http();
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            String responseBody = response.getBody();
            Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
            Map<String, Object> mainData = (Map<String, Object>) jsonResponse.get('main');
            Double temperature = (Double) mainData.get('temp');
            return temperature;
        } else {
            // API call failed
            
            System.debug('API Call failed with status code: ' + response.getStatusCode());
            System.debug('Error message: ' + response.getBody());
            
            return null;
        }
    }
}