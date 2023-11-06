CREATE OR REPLACE VIEW ActressesWithWoodyHarrelson AS
WITH MovieCast AS (
    SELECT
        show_id,
        CAST(SPLIT_PART(cast, ', ', 1) AS STRING) AS actor_name
    FROM
        Movies.MovieTvShowFact
    WHERE
        CAST(SPLIT_PART(cast, ', ', 1) AS STRING) = 'Woody Harrelson'
),
ActressesInSameMovies AS (
    SELECT
        M1.show_id,
        M1.actor_name AS actress_name
    FROM
        MovieCast M1
    JOIN
        MovieCast M2
    ON
        M1.show_id = M2.show_id
    WHERE
        M1.actor_name != 'Woody Harrelson'
)
SELECT
    actress_name,
    COUNT(show_id) AS movie_count
FROM
    ActressesInSameMovies
GROUP BY
    actress_name
HAVING
    COUNT(show_id) > 1
ORDER BY
    movie_count DESC;
