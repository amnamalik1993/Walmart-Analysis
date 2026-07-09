{{
config
({
"materialized":'incremental',
"incremental_strategy": 'delete+insert',
"unique_key": 'STORE_ID',
"merge_exclude_columns" : ['INSERT_DATE'],
"schema":"silver"
})
}}

WITH walmart_store_dim AS
(
SELECT
    S.STORE_ID,
    D.DEPT_ID,
    S.TYPE AS STORE_TYPE,
    S.SIZE AS STORE_SIZE,
    S.INSERT_DTS AS INSERT_DATE,
    S.UPDATE_DTS AS UPDATE_DATE
FROM
    {{ ref('walmart_store') }} AS S
JOIN 
    {{ ref('walmart_department') }} AS D
ON 
    S.STORE_ID = D.STORE_ID

)

SELECT 
    *
FROM  walmart_store_dim 
