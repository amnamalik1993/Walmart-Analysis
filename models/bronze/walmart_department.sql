{{ config({ "materialized":'table',
 "transient":true,
 "alias":'walmart_department',
 "pre_hook": dept_copy_csv('WALMART_DEPARTMENT_RAW'),
 "schema": 'BRONZE'

})}}

WITH department AS (
SELECT
    STORE AS STORE_ID,
    DEPT AS DEPT_ID,
    DATE,
    WEEKLY_SALES,
    ISHOLIDAY,
    INSERT_DTS,
    UPDATE_DTS,
    SOURCE_FILE_ROW_NUMBER AS DATE_ID
FROM   {{source('source','WALMART_DEPARTMENT_RAW')}}
)

SELECT 
    *
FROM    
    department