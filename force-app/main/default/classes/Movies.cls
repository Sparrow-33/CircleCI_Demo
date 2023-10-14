public with sharing class Movies {
    @AuraEnabled
    public static Movie__c getMovieById(Id movieId){
        try {
            return [SELECT Name, Type__c, Description__c, Rating__c FROM Movie__c WHERE Id = :movieId ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

        @AuraEnabled
        public static List<Movie__c> getMovies(){
            try {
                return [SELECT Name, Type__c, Description__c, Rating__c FROM Movie__c];
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }

}