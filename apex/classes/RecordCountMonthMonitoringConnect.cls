public with sharing class RecordCountMonthMonitoringConnect implements RecordCountMonthMonitoringScheduler.IScheduler {
    
    /**
     * execute
     */
    public void execute(SchedulableContext sc) {
        // 集計処理実行
        RecordCountMonthMonitoringController cls = new RecordCountMonthMonitoringController();
    }
}