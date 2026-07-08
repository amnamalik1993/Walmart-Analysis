{% snapshot walmart_fact_snapshot %}

{{
    config(
        target_database='WALMART_DB',
        target_schema='SNAPSHOTS',
        unique_key='SNAPSHOT_KEY',
        strategy='check',
        check_cols=[
            'STORE_WEEKLY_SALES',
            'FUEL_PRICE',
            'STORE_TEMPERATURE',
            'UNEMPLOYMENT',
            'CPI',
            'MARKDOWN1',
            'MARKDOWN2',
            'MARKDOWN3',
            'MARKDOWN4',
            'MARKDOWN5'
        ]
    )
}}

SELECT
    CONCAT(STORE_ID, '-', DEPT_ID, '-', DATE_ID) AS SNAPSHOT_KEY,
    *
FROM {{ source('silver', 'WALMART_FACT_TABLE') }}

{% endsnapshot %}


