SELECT
  ARRAY_TO_STRING(event," >> ") as sequence,
  Count(*) as count
FROM(
  SELECT 
    user_pseudo_id,
    ARRAY_AGG(event_name order by event_timestamp asc limit 5) as event
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` 
  group by 1
)
group by 1 
ORDER BY 2 DESC
