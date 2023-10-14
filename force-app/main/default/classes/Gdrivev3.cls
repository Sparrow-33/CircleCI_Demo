public class Gdrivev3 {
    
    public static void createFolder(String folderName) {
        // Define the request parameters
        String endpoint = 'callout:google/v3/files';
        String contentType = 'application/json';
        String body = '{ "name": "' + folderName + '", "mimeType": "application/vnd.google-apps.folder" }';

        // Send the request to create the folder
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', contentType);
        request.setBody(body);
        HttpResponse response = new Http().send(request);

        // Check the response status code and log any errors
        if (response.getStatusCode() != 200) {
            System.debug('Failed to create Google Drive folder. HTTP status code: ' + response.getStatusCode());
            System.debug('Response body: ' + response.getBody());
        }
    }


}