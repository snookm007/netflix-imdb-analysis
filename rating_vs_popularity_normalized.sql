SELECT
  CAST(r.imdb_score AS FLOAT64) AS rating,
  CAST(r.imdb_votes AS INT64) AS votes
FROM `capstone-492815.netflix_m_and_s.titles` t
JOIN `capstone-492815.netflix_ratings_imdb.ratings` r
ON TRIM(LOWER(t.title)) = TRIM(LOWER(r.title))
AND CAST(t.release_year AS INT64) = CAST(r.release_year AS INT64)