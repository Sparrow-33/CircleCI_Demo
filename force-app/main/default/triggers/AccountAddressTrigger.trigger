trigger AccountAddressTrigger on Account (before insert, before update) {

    for (Account a :Trigger.new) {
         System.debug('VALUE OF : '+a.Match_Billing_Address__c);
        if (a.Match_Billing_Address__c && a.BillingPostalCode != null ) {
            a.ShippingPostalCode = a.BillingPostalCode;
        }
    }
}