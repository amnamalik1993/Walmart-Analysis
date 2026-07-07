{% macro macros_copy_csv(table_nm) %}

    delete from {{ var("rawhist_db") }}.{{ var("wrk_schema") }}.{{ table_nm }};

COPY INTO {{var ('rawhist_db') }}.{{var ('wrk_schema')}}.{{ table_nm }} 

FROM 

(
SELECT
    $1 AS STORE,
    $2 AS DATE,
    $3 AS WEEKLY_SALES,
    $4 AS TEMPERATURE,
    $5 AS FUEL_PRICE,
    $6 AS MARKDOWN1,
    $7 AS MARKDOWN2,
    $8 AS MARKDOWN3,
    $9 AS MARKDOWN4,
    $10 AS MARKDOWN5,
    $11 AS CPI
    $12 AS UNEMPLOYMENT
    $13 AS ISHOLIDAY
    CURRENT_TIMESTAMP() AS INSERT_DTS,
    CURRENT_TIMESTAMP() AS UPDATE_DTS,
    METADATA$FILENAME AS SOURCE_FILE_NAME,
    METADATA$FILE_ROW_NUMBER AS SOURCE_FILE_ROW_NUMBER
FROM @{{ var('fact_stage_name') }}
)
FILE_FORMAT = {{var ('file_format_csv') }}
PURGE={{ var('purge_status') }}
FORCE = TRUE;

{% endmacro %}

