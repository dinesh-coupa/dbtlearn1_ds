WITH f AS(
SELECT * FROM {{ ref('fct_reviews') }}
),
d AS (
SELECT * FROM {{ ref('dim_listings_cleansed') }}
)
SELECT 1 FROM f JOIN d ON f.listing_id = d.listing_id
AND f.review_date < d.created_at