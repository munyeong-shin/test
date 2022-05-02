SELECT
  page_title,
  COUNT(*) as count
FROM(
SELECT
    user_pseudo_id,
    ARRAY_TO_STRING(ARRAY_AGG(page_title order by event_timestamp asc)," >> ") as page_title
  FROM( 
    SELECT 
      user_pseudo_id ,event_timestamp, (SELECT value.string_value FROM UNNEST(event_params) WHERE key ="page_title") as page_title
    FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` 
    WHERE event_name ="page_view"
    and (SELECT value.string_value FROM UNNEST(event_params) WHERE key ="page_title") is not null
    and (SELECT value.string_value FROM UNNEST(event_params) WHERE key ="page_title") != ""
    group by 1,2,3
  )
  group by 1
)
group by 1
order by 2 desc
