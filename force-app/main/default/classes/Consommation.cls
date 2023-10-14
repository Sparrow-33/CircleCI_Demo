public class Consommation {
    
    public static void insertConsommation() {
        
        List<Consommation__c> consomList = new List<Consommation__c>();
        String data =  DataSet.getCalloutResponceContents('https://erdf.opendatasoft.com/api/v2/catalog/datasets/conso-sup36-region/records?limit=15&offset=0&timezone=UTC');
        JsonMapper mappedData = JsonMapper.parse(data);
        
        for (JsonMapper.cls_records record : mappedData.records) {
             JsonMapper.cls_fields fields = record.record.fields;
             
            Consommation__c consom = new Consommation__c (
               // consom.Name = fields.name;
             //   consom.horodate = JSON.deserialize(fields.horodate, DateTime.class);
                region__c = fields.region                
            );
            
            consomList.add(consom);
        
        }
        
      insert consomList;
    }

}