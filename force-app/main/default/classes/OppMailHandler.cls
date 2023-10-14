public class OppMailHandler {
    
    public static void sendEmailOnOppUpdate(List<Opportunity> ops, Map<Id, Opportunity> oldOppsMap) {
                
        List<Opportunity> closedWonOpps = new List<Opportunity>();
        List<Opportunity> oppsToUpdate = new List<Opportunity>();
         List<Id> oppsIds = new List<Id>();
        
        Double exchangeRate; 
        
        for(Opportunity op : ops) {
            if(op.StageName == 'Closed Won' && oldOppsMap.get(op.Id).StageName != 'Closed Won') {
                closedWonOpps.add(op);
                oppsIds.add(op.Id);
            }
        }
        
        if(!closedWonOpps.isEmpty()) {
            
            List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
            List<OpportunityLineItem> lineItems = new List<OpportunityLineItem>();
         //  List<Id> oppContact = [SELECT ContactId FROM Opportunity WHERE Id IN :oppIds];

            
            EmailTemplate template = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'oppUpdate'];
            
            getUDSMADExchangeRate(exchangeRate);
            
          //  for (Opportunity opp : closedWonOpps) {
              for (Integer i = 0; i < closedWonOpps.size(); i++) {
                closedWonOpps.get(i).Exchange_Rate__c = exchangeRate;
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setTemplateId(template.Id);
                email.setTargetObjectId(closedWonOpps.get(i).ContactId);  
                email.setWhatId(closedWonOpps.get(i).Id);  
                email.setToAddresses(new String[] {'elhaoudihaytham2001@gmail.com'});  
                email.setSaveAsActivity(false);
                
                lineItems.addAll([SELECT Product2.Name, Quantity FROM OpportunityLineItem WHERE OpportunityId = : closedWonOpps.get(i).Id]);
                
             //   if(!lineItems.isEmpty()) {
                    // Create the PDF attachment
                Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
                attachment.setFileName('Opportunity_Details.pdf');
                attachment.setBody(generatePDFContent(lineItems));
                
                // Attach the PDF to the email
                email.setFileAttachments(new Messaging.EmailFileAttachment[]{attachment});
                
           //     }

                emailList.add(email);
            }
            update closedWonOpps;
            Messaging.sendEmail(emailList);
        }
    }
    
      private static Blob generatePDFContent(List<OpportunityLineItem> oppLineItems) {
        PageReference pageRef = Page.OppPdf;
        pageRef.getParameters().put('OpportunityLineItems', JSON.serialize(oppLineItems));
        
        // Generate the PDF content
        return pageRef.getContentAsPDF();
    }
    
        @future(callout=true)
        public static void getUDSMADExchangeRate(Double exRate) {
         HttpRequest req = new HttpRequest();
        req.setEndpoint('http://apilayer.net/api/live?access_key=6452fd6e6bcf4b2c3bb6768508d5449c&currencies=MAD&source=USD&format=1');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        Map<String, Object> quotesMap = (Map<String, Object>)responseMap.get('quotes');
        exRate  = (Double)quotesMap.get('USDMAD');
    }
    
    
}