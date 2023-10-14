public class Gdrivev2 {

        public static void createGoogleDriveFolder(String folderName) {
            System.debug('FORLER NAME '+ folderName);

        Http http = new Http();
        HttpRequest req = new HttpRequest();

        String reqPath = 'callout:google';
        req.setEndpoint(reqPath);
        req.setMethod('POST');
        req.setHeader('content-type', 'application/json');
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
            
        gen.writeStringField('mimeType', 'application/vnd.google-apps.folder');
            
        gen.writeStringField('name', folderName);
        gen.writeEndObject();
        String reqBody = gen.getAsString();
        req.setBody(reqBody);

        HttpResponse res = http.send(req);
          

        if (res.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            
            System.debug('The result :'+results);
        }else {
             System.debug('Failed to create Google Drive folder. HTTP status code: ' + res.getStatusCode());
                System.debug('Response body: ' + res.getBody());
        }

    }
    
        public static void createFoldersForAllObj() {
        
        List<String> objects = ObjectsUtilities.getOrgObjectsNames();
        
        for(String obj : objects) {
            createGoogleDriveFolder(obj);
        }
        
    }
    

    
       public static Boolean checkIFolderExists(String folderName) {
           
            String folderId = null;
            try {
                Http http = new Http();
                HttpRequest req = new HttpRequest();
        
                // Specify the login information to use
                String reqPath = 'callout:google';
                req.setEndpoint(reqPath);
                req.setMethod('GET');
                req.setHeader('content-type', 'application/json');
        
                // Construct the query to check if the folder already exists
                String query = 'trashed=false and mimeType=\'application/vnd.google-apps.folder\' and name=\'' + folderName + '\'';
                String encodedQuery = EncodingUtil.urlEncode(query, 'UTF-8');
                String url = 'https://www.googleapis.com/drive/v3/files?q=' + encodedQuery;
        
                // Send the request to Google Drive API
                req.setEndpoint(url);
                HttpResponse res = http.send(req);
        
                if (res.getStatusCode() == 200) {
                    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                    List<Object> items = (List<Object>) results.get('files');
                    if (!items.isEmpty()) {
                        return true;
                        
                    }
                        return false;
                } else {
                    System.debug('Failed to check if Google Drive folder exists. HTTP status code: ' + res.getStatusCode());
                    System.debug('Response body: ' + res.getBody());
                    return null;
                }
        
            } catch (Exception e) {
                System.debug('Exception caught while checking if Google Drive folder exists: ' + e.getMessage());
                return null;
            }
        
   }
    
    
    public static void uploadFileToGDrive(String fileName, String fileBody, String folderId) {
        
        
        // Create the request to upload the file
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint('callout:GoogleDrive/v3/files?uploadType=multipart');
        
        // Create the metadata for the file
        Map<String, Object> fileMetadata = new Map<String, Object>();
        fileMetadata.put('name', fileName);
        fileMetadata.put('parents', new List<String>{folderId});
        
        // Convert the metadata to JSON and add it to the request body
        String fileMetadataJSON = JSON.serialize(fileMetadata);
        req.setBody('--boundary\nContent-Type: application/json; charset=UTF-8\n\n' + fileMetadataJSON + '\n--boundary\nContent-Type: application/octet-stream\n\n' + fileBody + '\n--boundary--');
        
        // Send the request and get the response
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        if (res.getStatusCode() == 200) {
            System.debug('File uploaded successfully');
        } else {
            System.debug('Failed to upload file. HTTP status code: ' + res.getStatusCode());
            System.debug('Response body: ' + res.getBody());
        }
        
    }
    
      
    
}