SELECT
  t.title,
  t.type,
  t.release_year,
  r.imdb_score,
  r.imdb_votes,
  t.listed_in
FROM `capstone-492815.netflix_m_and_s.titles` t
JOIN `capstone-492815.netflix_ratings_imdb.ratings` r
ON TRIM(LOWER(t.title)) = TRIM(LOWER(r.title))
AND CAST(t.release_year AS INT64) = CAST(r.release_year AS INT64)