{{
config
({
"materialized":'table',
"schema":"silver"
})
}}

WITH WALMART_DATE_DIM AS (
SELECT  
    ROW_NUMBER() OVER (ORDER BY DATE) AS DATE_ID,
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
