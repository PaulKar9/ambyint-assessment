CREATE OR REPLACE VIEW DataValidation AS
SELECT
    'Missing Show ID' AS Issue,
    COUNT(*) AS Count
FROM
    Movies.MovieTvShowFact
WHERE
    show_id IS NULL
UNION ALL
SELECT
    'Missing Title' AS Issue,
    COUNT(*) AS Count
FROM
    Movies.MovieTvShowFact
WHERE
    title IS NULL
UNION ALL
SELECT
    'Invalid Release Year' AS Issue,
    COUNT(*) AS Count
FROM
    Movies.MovieTvShowFact
WHERE
    release_year < 1900 OR release_year > YEAR(CURRENT_DATE())
UNION ALL
SELECT
    'Invalid TV Rating' AS Issue,
    COUNT(*) AS Count
FROM
    Movies.MovieTvShowFact
WHERE
    rating_id NOT IN (SELECT DISTINCT rating_id FROM Movies.TvRating)
UNION ALL
SELECT
    'Invalid Country' AS Issue,
    COUNT(*) AS Count
FROM
    Movies.MovieTvShowFact
WHERE
    country_id NOT IN (SELECT DISTINCT country_id FROM Movies.Country);