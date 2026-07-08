{{ 
config
(
materialized ='view',
alias='WALMART_FACT_VIEW',
schema= 'GOLD'

)}}

WITH view AS (

SELECT  
    SNAPSHOT_KEY AS SURR_KEY,
    STORE_ID,
    DEPT_ID,
    DATE_ID,
    STORE_WEEKLY_SALES,
    FUEL_PRICE,
    STORE_TEMPERATURE,
    UNEMPLOYMENT,
    CPI,
    MARKDOWN1, 
    MARKDOWN2, 
    MARKDOWN3, 
    MARKDOWN4,
    MARKDOWN5,
    INSERT_DATE, 
    UPDATE_DATE,
    DBT_VALID_FROM AS VRSN_START_DATE,
    COALESCE(DBT_VALID_TO , '9999-12-31 00:00:00.000')::string AS VRSN_END_DATE
FROM {{ ref('walmart_fact_snapshot') }}
)

SELECT * FROM view