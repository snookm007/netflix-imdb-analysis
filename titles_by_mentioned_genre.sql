SELECT
  t.listed_in AS genre,
  AVG(CAST(r.imdb_score AS FLOAT64)) AS avg_rating,
  COUNT(*) AS total_titles
FROM `capstone-492815.netflix_m_and_s.titles` t
JOIN `capstone-492815.netflix_ratings_imdb.ratings` r
ON TRIM(LOWER(t.title)) = TRIM(LOWER(r.title))
AND CAST(t.release_year AS INT64) = CAST(r.release_year AS INT64)
GROUP BY genre
ORDER BY avg_rating DESC
LIMIT 400;