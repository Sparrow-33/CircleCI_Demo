public with sharing class ClosedOpportunityHandler {
    public static void handleClosedOpps(List<Opportunity> opps) {
        List<Id> opportunityIds = new List<Id>();
        
        for (Opportunity opp : opps) {
            opportunityIds.add(opp.Id);
        }

        List<Opportunity> oppsToUpdate = [
            SELECT Id, StageName
            FROM Opportunity 
            WHERE Id IN :opportunityIds
            AND StageName = 'Closed Won'
        ];

        List<Task> taskToCreate = new List<Task>();

        for (Opportunity opp : oppsToUpdate) {
            taskToCreate.add(
                new Task(
                    Subject = 'Follow Up Test Task',
                    WhatId = opp.Id
                )
            );
        }

        insert taskToCreate;
    }
}