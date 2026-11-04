# Netflix and IMDb Analysis

A collection of Google BigQuery SQL queries that compares Netflix catalog titles with IMDb ratings and vote counts.

## Project overview

This project explores the overlap between Netflix titles and IMDb records. The queries match records by title and release year, then use IMDb scores and vote counts to examine ratings across content types and Netflix's listed categories.

The analysis can help answer questions such as:

- How do average IMDb ratings compare between Netflix movies and TV shows?
- What ratings and vote counts appear for titles that match across both datasets?
- How do IMDb ratings vary across the category values listed for Netflix titles?

## Repository contents

| File | Purpose |
| --- | --- |
| [`title_and_year_match.sql`](title_and_year_match.sql) | Lists matched titles with content type, release year, IMDb score, IMDb vote count, and Netflix's `listed_in` value. |
| [`avg_imdb_rating_and_title_count_by_type.sql`](avg_imdb_rating_and_title_count_by_type.sql) | Groups matched rows by Netflix content type and calculates average IMDb score and row count. |
| [`titles_by_mentioned_genre.sql`](titles_by_mentioned_genre.sql) | Groups matched rows by the full Netflix `listed_in` value and calculates average IMDb score and row count. |
| [`imdb_rating_and_vote_counts.sql`](imdb_rating_and_vote_counts.sql) | Returns IMDb scores and vote counts for matched rows. |

## Data and matching

The queries expect two tables in Google BigQuery:

- Netflix catalog: `capstone-492815.netflix_m_and_s.titles`
- IMDb ratings: `capstone-492815.netflix_ratings_imdb.ratings`

The join matches rows when both conditions are true:

1. Titles match after trimming surrounding whitespace and converting text to lowercase.
2. Release years match after being cast to integers.

This is a simple matching rule. It may miss records where titles differ between datasets, and it may produce multiple joined rows when a title and year occur more than once. The resulting counts and averages should therefore be interpreted as summaries of joined rows, not necessarily unique films or shows.

## Requirements

- Access to a Google Cloud project with BigQuery enabled.
- Permission to query the two tables listed above.
- The source columns referenced by the queries, including title, release year, type, listed-in categories, IMDb score, and IMDb votes.

The SQL uses BigQuery Standard SQL syntax, including backtick-quoted table names and BigQuery data types such as `FLOAT64` and `INT64`.

## Running the queries

1. Sign in to the Google Cloud Console and open BigQuery.
2. Open a SQL query editor.
3. Copy a query from one of the `.sql` files into the editor.
4. Confirm that your account can access the referenced tables, then run the query.
5. Review the results and consider the matching limitations above when interpreting them.

The queries use fully qualified table names, so they can be run directly when you have access to those tables. If your tables are in a different project or dataset, update the table names in the SQL first.

## Interpretation notes and opportunities

- `titles_by_mentioned_genre.sql` groups by the entire `listed_in` field. If that field contains several comma-separated categories, the query treats the combination as one group rather than splitting it into individual genres.
- `avg_imdb_rating_and_title_count_by_type.sql` counts joined rows with `COUNT(*)`. It reports the number of matched rows, not necessarily unique titles.
- `imdb_rating_and_vote_counts.sql` returns raw rating and vote values. It does not define a popularity measure or normalize values.
- The joins use exact title-and-year equality after basic text cleanup. More robust matching could account for alternate titles, release-year differences, duplicate records, and content type.
- The current queries do not document data provenance, refresh dates, or query results. Add these details when they are known.

## Possible next steps

1. Validate the table schemas and inspect duplicate title/year combinations.
2. Decide how to handle multiple category values in `listed_in`.
3. Define a popularity metric and normalization method before comparing popularity with ratings.
4. Record a few key findings, with result dates and caveats, in this README.
