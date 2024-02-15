{{
  config(
    materialized = 'table'
    )
}}

WITH src_supplier AS(
    SELECT 
    * 
    FROM 
    {{ ref(var('seed_supplier_name')) }}
)
SELECT
    supplier_name,
    contact_name
FROM
    src_supplier
WHERE
    contact_name NOT LIKE '%#%'
