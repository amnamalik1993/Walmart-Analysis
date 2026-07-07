{{
config
({
"materialized":'table',
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
    CURRENT_TIMESTAMP() AS INSERT_DATE,
    CURRENT_TIMESTAMP() AS UPDATE_DATE
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
