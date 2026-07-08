{{
config
({
"materialized":'table',
"schema":"silver"
})
}}

WITH WALMART_FACT_TABLE AS (
SELECT  
    D.STORE_ID,
    D.DEPT_ID,
    D.DATE_ID,
    D.WEEKLY_SALES AS STORE_WEEKLY_SALES,
    F.FUEL_PRICE,
    F.TEMPERATURE AS STORE_TEMPERATURE,
    F.UNEMPLOYMENT,
    F.CPI,
    F.MARKDOWN1, 
    F.MARKDOWN2, 
    F.MARKDOWN3, 
    F.MARKDOWN4,
    F.MARKDOWN5,
    F.INSERT_DTS AS INSERT_DATE, 
    F.UPDATE_DTS AS UPDATE_DATE,
    CURRENT_TIMESTAMP() AS VRSN_START_DATE,
    CURRENT_TIMESTAMP() AS VRSN_END_DATE
FROM
    {{ ref('walmart_fact') }} AS F

JOIN
    {{ ref('walmart_department') }} AS D
ON
    F.STORE_ID = D.STORE_ID
    AND F.DATE = D.DATE

)

SELECT * FROM WALMART_FACT_TABLE