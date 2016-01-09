@isTest
private class RecordCountMonthMonitoringConnectTest {

    private static User testAdminUser = new User(Id = UserInfo.getUserId());

    /**
     * スケジュールバッチ
     */
    static testMethod void RecordCountMonthMonitoringConnectTest() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            RecordCountMonthMonitoringScheduler cls = new RecordCountMonthMonitoringScheduler();
            // パラメータ
            String sch = '0 0 0 1 1 ?';
            // バッチスケジュール起動
            System.schedule('RecordCountMonthMonitoringSchedulerTestJob',sch, cls);  
            
            Test.stopTest();
        }
    }
}