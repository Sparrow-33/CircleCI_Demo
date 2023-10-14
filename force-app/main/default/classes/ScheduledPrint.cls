global class ScheduledPrint implements Schedulable {
    global void execute(SchedulableContext sc) {
        System.debug('Hello from a scheduled apex');
    }
}