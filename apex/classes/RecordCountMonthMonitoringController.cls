public with sharing class RecordCountMonthMonitoringController {
    
    /**
     * コンストラクタ
     */
    public RecordCountMonthMonitoringController() {
        // 集計期間の年月取得(先月)
        Integer year = System.today().year();
        Integer month = System.today().month() - 1;
        // レコード件数モニタリング作成
        this.createRecordCountMonitoring(year, month);
    }
    
    /**
     * コンストラクタ(任意の年月で集計する場合)
     */
    public RecordCountMonthMonitoringController(Integer year, Integer month) {
        // レコード件数モニタリング作成
        this.createRecordCountMonitoring(year, month);
    }
    
    /**
     * レコード件数モニタリング作成
     */
    private void createRecordCountMonitoring(Integer year, Integer month) {
        // 各オブジェクトのレコード件数取得
        Integer accountCnt = this.getAccountCount(year, month);
        Integer contactCnt = this.getContactCount(year, month);
        Integer opportunityCnt = this.getOpportunityCount(year, month);
        // レコード件数モニタリング作成情報取得
        RecordCountMonitoring__c recordCntMonitoring = this.getRecordCountMonitoring(accountCnt, contactCnt, opportunityCnt, year, month);
        // レコード件数モニタリング作成
        insert recordCntMonitoring;
    }

    /**********************/
    /* Helper             */
    /**********************/
    
    /**
     * 取引先件数取得
     */
    private Integer getAccountCount(Integer year, Integer month) {
        return [
                SELECT
                    COUNT()
                FROM
                    Account
                WHERE
                    CALENDAR_YEAR(CreatedDate) =: year
                AND
                    CALENDAR_MONTH(CreatedDate) =: month
                LIMIT 50000
        ];
    }
    
    /**
     * 取引先責任者件数取得
     */
    private Integer getContactCount(Integer year, Integer month) {
        return [
                SELECT
                    COUNT()
                FROM
                    Contact
                WHERE
                    CALENDAR_YEAR(CreatedDate) =: year
                AND
                    CALENDAR_MONTH(CreatedDate) =: month
                LIMIT 50000
        ];
    }
    
    /**
     * 商談件数取得
     */
    private Integer getOpportunityCount(Integer year, Integer month) {
        return [
                SELECT
                    COUNT()
                FROM
                    Opportunity
                WHERE
                    CALENDAR_YEAR(CreatedDate) =: year
                AND
                    CALENDAR_MONTH(CreatedDate) =: month
                LIMIT 50000
        ];
    }
    
    /**
     * レコード件数モニタリング作成情報取得
     */
    @TestVisible
    private RecordCountMonitoring__c getRecordCountMonitoring(Integer accountCnt, Integer contactCnt, Integer opportunityCnt, Integer year, Integer month) {
        // 集計期間(FROM)取得
        Date periodFromDate = Date.newInstance(year, month, 1);
        // 集計期間(TO)取得
        Date periodToDate = this.getMonthOfEndDay(periodFromDate);
        
        // レコード件数モニタリング
        RecordCountMonitoring__c recordCntMonitoring = new RecordCountMonitoring__c(
             AccountCount__c = accountCnt
            ,ContactCount__c = contactCnt
            ,OpportunityCount__c  = opportunityCnt
            ,PeriodFromDate__c = periodFromDate
            ,PeriodToDate__c  = periodToDate
        );
        
        return recordCntMonitoring;
    }
    
    /**
     * 月末日付取得
     */
    @TestVisible
    private Date getMonthOfEndDay(Date prmDate) {
        return prmDate != null ? Date.newInstance(prmDate.year(), prmDate.month() + 1 ,0) : null;
    }
}