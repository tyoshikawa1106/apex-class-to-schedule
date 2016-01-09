@isTest
private class RecordCountMonthMonitoringControllerTest {

    private static User testAdminUser = new User(Id = UserInfo.getUserId());

    /**
     * コンストラクタ
     * レコード:0件
     */
    static testMethod void RecordCountMonthMonitoringControllerTest1() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            // コンストラクタ
            RecordCountMonthMonitoringController cls = new RecordCountMonthMonitoringController();
            
            Test.stopTest();
            
            // レコード件数モニタリング作成結果確認
            List<RecordCountMonitoring__c> results = getTestResultRecordCountMonitoringList();
            System.assertEquals(results.size(), 1);
            System.assertEquals(results[0].AccountCount__c, 0);
            System.assertEquals(results[0].ContactCount__c, 0);
            System.assertEquals(results[0].OpportunityCount__c, 0);
        }
    }
    
    /**
     * コンストラクタ
     * 取引先レコード:1件
     */
    static testMethod void RecordCountMonthMonitoringControllerTest2() {
        
        System.runAs(testAdminUser) {
            
            Account account = createAccount(true);

            Test.startTest();
            
            // コンストラクタ
            RecordCountMonthMonitoringController cls = new RecordCountMonthMonitoringController();
            
            Test.stopTest();
            
            // レコード件数モニタリング作成結果確認
            List<RecordCountMonitoring__c> results = getTestResultRecordCountMonitoringList();
            System.assertEquals(results.size(), 1);
            System.assertEquals(results[0].AccountCount__c, 1);
            System.assertEquals(results[0].ContactCount__c, 0);
            System.assertEquals(results[0].OpportunityCount__c, 0);
        }
    }
    
    /**
     * コンストラクタ
     * 取引先責任者レコード:1件
     */
    static testMethod void RecordCountMonthMonitoringControllerTest3() {
        
        System.runAs(testAdminUser) {
            
            Account account = createAccount(true);
            Contact contact = createContact(account, true);

            Test.startTest();
            
            // コンストラクタ
            RecordCountMonthMonitoringController cls = new RecordCountMonthMonitoringController();
            
            Test.stopTest();
            
            // レコード件数モニタリング作成結果確認
            List<RecordCountMonitoring__c> results = getTestResultRecordCountMonitoringList();
            System.assertEquals(results.size(), 1);
            System.assertEquals(results[0].AccountCount__c, 1);
            System.assertEquals(results[0].ContactCount__c, 1);
            System.assertEquals(results[0].OpportunityCount__c, 0);
        }
    }
    
    /**
     * コンストラクタ
     * 商談レコード:1件
     */
    static testMethod void RecordCountMonthMonitoringControllerTest4() {
        
        System.runAs(testAdminUser) {
            
            Account account = createAccount(true);
            Opportunity opportunity = createOpportunity(account, true);

            Test.startTest();
            
            // コンストラクタ
            RecordCountMonthMonitoringController cls = new RecordCountMonthMonitoringController();
            
            Test.stopTest();
            
            // レコード件数モニタリング作成結果確認
            List<RecordCountMonitoring__c> results = getTestResultRecordCountMonitoringList();
            System.assertEquals(results.size(), 1);
            System.assertEquals(results[0].AccountCount__c, 1);
            System.assertEquals(results[0].ContactCount__c, 0);
            System.assertEquals(results[0].OpportunityCount__c, 1);
        }
    }
    
    /**
     * コンストラクタ
     * 複数件
     */
    static testMethod void RecordCountMonthMonitoringControllerTest5() {
        
        System.runAs(testAdminUser) {
            
            List<Account> accounts = new List<Account>();
            for (Integer i = 0; i < 201; i++) {
                Account a = createAccount(false);
                accounts.add(a);
            }
            insert accounts;
            System.assertEquals(accounts.size(), 201);
            
            Opportunity opportunity = createOpportunity(accounts[0], true);

            Test.startTest();
            
            // コンストラクタ
            RecordCountMonthMonitoringController cls = new RecordCountMonthMonitoringController();
            
            Test.stopTest();
            
            // レコード件数モニタリング作成結果確認
            List<RecordCountMonitoring__c> results = getTestResultRecordCountMonitoringList();
            System.assertEquals(results.size(), 1);
            System.assertEquals(results[0].AccountCount__c, 201);
            System.assertEquals(results[0].ContactCount__c, 0);
            System.assertEquals(results[0].OpportunityCount__c, 1);
        }
    }

    /**
     * コンストラクタ(任意の年月で集計する場合)
     */
    static testMethod void RecordCountMonthMonitoringControllerTest6() {
        
        System.runAs(testAdminUser) {
            
            Integer year = 2015;
            Integer month = 4;

            Test.startTest();
            
            // コンストラクタ
            RecordCountMonthMonitoringController cls = new RecordCountMonthMonitoringController(year, month);
            
            Test.stopTest();
            
            // レコード件数モニタリング作成結果確認
            List<RecordCountMonitoring__c> results = getTestResultRecordCountMonitoringList();
            System.assertEquals(results.size(), 1);
            System.assertEquals(results[0].AccountCount__c, 0);
            System.assertEquals(results[0].ContactCount__c, 0);
            System.assertEquals(results[0].OpportunityCount__c, 0);
        }
    }

    /**
     * レコード件数モニタリング作成情報取得
     * レコード:0件
     */
    static testMethod void getRecordCountMonitoringTest1() {
        
        System.runAs(testAdminUser) {

            Integer accountCnt = 0;
            Integer contactCnt = 0;
            Integer opportunityCnt = 0;
            Integer year = 2010;
            Integer month = 1;

            // コンストラクタ
            RecordCountMonthMonitoringController cls = new RecordCountMonthMonitoringController();

            Test.startTest();
            
            RecordCountMonitoring__c result = cls.getRecordCountMonitoring(accountCnt, contactCnt, opportunityCnt, year, month);
            
            Test.stopTest();
            
            // レコード件数モニタリング作成結果確認
            System.assertEquals(String.isEmpty(result.Id), true);
            System.assertEquals(result.AccountCount__c, 0);
            System.assertEquals(result.ContactCount__c, 0);
            System.assertEquals(result.OpportunityCount__c, 0);
            System.assertEquals(result.PeriodFromDate__c, Date.newInstance(2010,1,1));
            System.assertEquals(result.PeriodToDate__c, Date.newInstance(2010,1,31));
        }
    }

    /**
     * レコード件数モニタリング作成情報取得
     * レコード:1件以上
     */
    static testMethod void getRecordCountMonitoringTest2() {
        
        System.runAs(testAdminUser) {

            Integer accountCnt = 10;
            Integer contactCnt = 5;
            Integer opportunityCnt = 3;
            Integer year = 2010;
            Integer month = 1;

            // コンストラクタ
            RecordCountMonthMonitoringController cls = new RecordCountMonthMonitoringController();

            Test.startTest();
            
            RecordCountMonitoring__c result = cls.getRecordCountMonitoring(accountCnt, contactCnt, opportunityCnt, year, month);
            
            Test.stopTest();
            
            // レコード件数モニタリング作成結果確認
            System.assertEquals(String.isEmpty(result.Id), true);
            System.assertEquals(result.AccountCount__c, accountCnt);
            System.assertEquals(result.ContactCount__c, contactCnt);
            System.assertEquals(result.OpportunityCount__c, opportunityCnt);
            System.assertEquals(result.PeriodFromDate__c, Date.newInstance(2010,1,1));
            System.assertEquals(result.PeriodToDate__c, Date.newInstance(2010,1,31));
        }
    }

    /**
     * 月末日付取得 テスト
     */
    static testMethod void getMonthOfEndDayTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            Date result;
            
            // 2014年01月
            result = CommonDate.getMonthOfEndDay(date.newInstance(2014, 01, 10));
            System.assertEquals(result, date.newInstance(2014, 01, 31));
            
            // 2014年02月
            result = CommonDate.getMonthOfEndDay(date.newInstance(2014, 02, 10));
            System.assertEquals(result, date.newInstance(2014, 02, 28));
            
            // 2014年03月
            result = CommonDate.getMonthOfEndDay(date.newInstance(2014, 03, 10));
            System.assertEquals(result, date.newInstance(2014, 03, 31));
            
            // 2014年04月
            result = CommonDate.getMonthOfEndDay(date.newInstance(2014, 04, 10));
            System.assertEquals(result, date.newInstance(2014, 04, 30));
            
            // 2014年05月
            result = CommonDate.getMonthOfEndDay(date.newInstance(2014, 05, 10));
            System.assertEquals(result, date.newInstance(2014, 05, 31));
            
            // 2014年06月
            result = CommonDate.getMonthOfEndDay(date.newInstance(2014, 06, 10));
            System.assertEquals(result, date.newInstance(2014, 06, 30));
            
            // 2014年07月
            result = CommonDate.getMonthOfEndDay(date.newInstance(2014, 07, 10));
            System.assertEquals(result, date.newInstance(2014, 07, 31));
            
            // 2014年08月
            result = CommonDate.getMonthOfEndDay(date.newInstance(2014, 08, 10));
            System.assertEquals(result, date.newInstance(2014, 08, 31));
            
            // 2014年09月
            result = CommonDate.getMonthOfEndDay(date.newInstance(2014, 09, 10));
            System.assertEquals(result, date.newInstance(2014, 09, 30));
            
            // 2014年10月
            result = CommonDate.getMonthOfEndDay(date.newInstance(2014, 10, 10));
            System.assertEquals(result, date.newInstance(2014, 10, 31));
            
            // 2014年11月
            result = CommonDate.getMonthOfEndDay(date.newInstance(2014, 11, 10));
            System.assertEquals(result, date.newInstance(2014, 11, 30));
            
            // 2014年12月
            result = CommonDate.getMonthOfEndDay(date.newInstance(2014, 12, 10));
            System.assertEquals(result, date.newInstance(2014, 12, 31));
            
            // 値なし
            result = CommonDate.getMonthOfEndDay(null);
            System.assertEquals(result, null);
            
            Test.stopTest();
        }
    }
    
    /**********************/
    /* Test Helper        */
    /**********************/
    
    /**
     * レコード件数モニタリング作成結果確認
     */
    private static List<RecordCountMonitoring__c> getTestResultRecordCountMonitoringList() {
        return [
            SELECT
                 Id
                ,AccountCount__c
                ,ContactCount__c
                ,OpportunityCount__c
                ,PeriodFromDate__c
                ,PeriodToDate__c
            FROM
                RecordCountMonitoring__c
            LIMIT 200
        ];
    }
    
    /**
     * 取引先
     */
    public static Account createAccount(Boolean isInsert) {
        
        Account account = new Account(       
             Name = 'Account Name'
        );
        
        if (isInsert) {
            insert account;
        }
        
        return account;
    }

    /**
     * 取引先責任者
     */
    public static Contact createContact(Account account, Boolean isInsert) {
        
        Contact contact = new Contact(
             AccountId = account.Id
            ,LastName = 'LastName'
            ,FirstName = 'FirstName'
        );
        
        if (isInsert) {
            insert contact;
        }
        
        return contact;
    }

    /**
     * 商談
     */
    public static Opportunity createOpportunity(Account account, Boolean isInsert) {
        
        Opportunity opportunity = new Opportunity(
             AccountId = account.Id
            ,Name = 'Name'
            ,CloseDate = date.newInstance(2011, 10, 5)
            ,StageName = '提案'
        );
        
        if (isInsert) {
            insert opportunity;
        }
        
        return opportunity;
    }
}