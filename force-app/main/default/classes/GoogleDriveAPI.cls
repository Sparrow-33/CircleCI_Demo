public class GoogleDriveAPI {
    private static final String API_VERSION = 'v3';
    private static final String DRIVE_SCOPE = 'https://www.googleapis.com/auth/drive';

    // Replace these values with your own client ID and secret
    private static final String CLIENT_ID = '848750661998-bnh0c4ob20umq3778uv7el3dta5s6369.apps.googleusercontent.com';
    private static final String CLIENT_SECRET = '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';

    public static void createFolder(String folderName) {
        // Get an access token for the Google Drive API
        String accessToken = getAccessToken();
        
        System.debug('AccessToken '+ accessToken);

        // Define the request parameters
        String endpoint = 'https://www.googleapis.com/drive/' + API_VERSION + '/files';
        String contentType = 'application/json';
        String body = '{ "name": "' + folderName + '", "mimeType": "application/vnd.google-apps.folder" }';

        // Send the request to create the folder
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        request.setHeader('Content-Type', contentType);
        request.setBody(body);
        HttpResponse response = new Http().send(request);

        // Check the response status code and log any errors
        if (response.getStatusCode() != 200) {
            System.debug('Failed to create Google Drive folder. HTTP status code: ' + response.getStatusCode());
            System.debug('Response body: ' + response.getBody());
        }
    }

    private static String getAccessToken() {
        // Define the request parameters
        String endpoint = 'https://accounts.google.com/o/oauth2/token';
        String grantType = 'refresh_token';
        String refreshToken = 'your-refresh-token'; // Replace with your own refresh token
        String contentType = 'application/x-www-form-urlencoded';
        String body = 'client_id=' + CLIENT_ID + '&client_secret=' + CLIENT_SECRET ;

        // Send the request to get a new access token
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', contentType);
        request.setBody(body);
        HttpResponse response = new Http().send(request);

        // Parse the response body to get the access token
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        return (String) responseMap.get('access_token');
    }
}