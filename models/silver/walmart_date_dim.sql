{{
config
({
"materialized":'incremental',
"incremental_strategy": 'merge',
"unique_key": 'DATE_ID',
"merge_exclude_columns" : ['INSERT_DATE'],
"schema":"silver"
})
}}

WITH WALMART_DATE_DIM AS (
SELECT  
    DATE_ID,
    DATE AS STORE_DATE,
    ISHOLIDAY,
    CURRENT_TIMESTAMP() AS INSERT_DATE,
    UPDATE_DTS AS UPDATE_DATE
FROM    
    {{ ref('walmart_department') }}
)

SELECT
    *
FROM  
    WALMART_DATE_DIM
