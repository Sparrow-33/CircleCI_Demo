trigger OppMailTrigger on Opportunity (after update) {
    
     System.debug('OPP MAIL TRIGG');
     OppMailHandler.sendEmailOnOppUpdate(Trigger.New,  Trigger.OldMap);

}