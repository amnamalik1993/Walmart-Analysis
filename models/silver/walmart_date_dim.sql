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
    TO_NUMBER(TO_CHAR(DATE, 'YYYYMMDD')) AS DATE_ID,
    DATE AS STORE_DATE,
    ISHOLIDAY,
    CURRENT_TIMESTAMP() AS INSERT_DATE,
    CURRENT_TIMESTAMP() AS UPDATE_DATE
FROM    
    {{ ref('walmart_department') }}
)

SELECT
    *
FROM  
    WALMART_DATE_DIM
