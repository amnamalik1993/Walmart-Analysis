{{ config({ "materialized":'table',
 "transient":true,
 "alias":'walmart_fact',
 "pre_hook": fact_copy_csv('WALMART_FACT_RAW'),
 "schema": 'BRONZE'

})}}

WITH FACT AS (
SELECT  
    STORE AS STORE_ID,
    DATE
    ,TEMPERATURE 
    ,FUEL_PRICE 
    ,MARKDOWN1 
    ,MARKDOWN2 
    ,MARKDOWN3 
    ,MARKDOWN4 
    ,MARKDOWN5
    ,CPI 
    ,UNEMPLOYMENT 
    ,ISHOLIDAY 
    ,INSERT_DTS 
    ,UPDATE_DTS 
FROM   {{source('source','WALMART_FACT_RAW')}}    
)

SELECT  
    *
FROM    
    FACT