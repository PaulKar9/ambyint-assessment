-- Create a view to find the movie with the longest timespan from release to appearing on Netflix
CREATE OR REPLACE VIEW LongestTimespanMovie AS
WITH MovieTimespan AS (
    SELECT
        title,
        release_year,
        date_added,
        DATEDIFF(YEAR, release_year, date_added) AS timespan_years
    FROM
        Movies.MovieTvShowFact
    WHERE
        type = 'Movie'
)
SELECT
    title,
    release_year,
    date_added,
    timespan_years
FROM
    MovieTimespan
ORDER BY
    timespan_years DESC
LIMIT 1;
