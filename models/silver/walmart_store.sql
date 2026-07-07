{{ config({ "materialized":'table',
 "transient":true,
 "alias":'walmart_store',
 "pre_hook": macros_copy_csv('WALMART_STORE_RAW'),
 "schema": 'SILVER'

})}}

 

WITH transform AS(

SELECT 
    STORE AS STORE_ID,
    TYPE,
    SIZE,
    INSERT_DTS,
    UPDATE_DTS
FROM {{source('source','WALMART_STORE_RAW')}}

)

 

SELECT *

FROM transform