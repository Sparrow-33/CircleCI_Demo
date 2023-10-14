public class AboutCases {
    
    public List<Case> getCaseWithNewStatus() {
        
        return [SELECT CaseNumber, Reason FROM Case WHERE STATUS = 'New' LIMIT 5];
    }

}