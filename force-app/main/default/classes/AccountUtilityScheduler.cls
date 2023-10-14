public class AccountUtilityScheduler implements Schedulable {
    public void execute(SchedulableContext context) {
        AccountUtility batchJob = new AccountUtility();
        Database.executeBatch(batchJob);
    }
}