trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {


    ClosedOpportunityHandler.handleClosedOpps(Trigger.New);
   
}