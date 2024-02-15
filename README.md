Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### How to Dynamically change Source for Transformation ?

Lets consider the below seed inputs - 
- seed/seed_supplier_coke.csv
- seed/seed_supplier_pepsi.csv

Each of the seed files have the below fields - 
- supplier_id, supplier_name, contact_name, contact_email, phone_number, address, city, country

Run the below commands to load the 2 seed files - 
```
dbt seed --select seed_supplier_coke
dbt seed --select seed_supplier_pepsi
```


Suppose we wish to do a generic Filter transform to read Suppliers with only a valid "supplier_name" values, we can create the the dbt Model under models/dim/dim_supplier_w_valid_names.sql with below logic - 

```
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
```


we can dynamically choose the source using the below dbt Run commands - 

To run Pepsi supplier - 
```
dbt run --models dim_supplier_w_valid_names --vars "{\"seed_supplier_name\": \"seed_supplier_pepsi\"}"
```

or To run Coke supplier - 
```
dbt run --models dim_supplier_w_valid_names --vars "{\"seed_supplier_name\": \"seed_supplier_coke\"}"
```

Default param can be set in the dbt_project.yml

By this technique, we can accomplish dynamic source for a dbt transformation. Let me know if this helps.