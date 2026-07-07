{% macro dept_copy_csv(table_nm) %}

    delete from {{ var("rawhist_db") }}.{{ var("wrk_schema") }}.{{ table_nm }};

COPY INTO {{var ('rawhist_db') }}.{{var ('wrk_schema')}}.{{ table_nm }} 

FROM 

(
SELECT
    $1 AS STORE,
    $2 AS DEPT,
    $3 AS DATE,
    $4 AS WEEKLY_SALES,
    $5 AS ISHOLIDAY,
    CURRENT_TIMESTAMP() AS INSERT_DTS,
    CURRENT_TIMESTAMP() AS UPDATE_DTS,
    METADATA$FILENAME AS SOURCE_FILE_NAME,
    METADATA$FILE_ROW_NUMBER AS SOURCE_FILE_ROW_NUMBER
FROM @{{ var('department_stage_name') }}
)
FILE_FORMAT = {{var ('file_format_csv') }}
PURGE={{ var('purge_status') }}
FORCE = TRUE;

{% endmacro %}

