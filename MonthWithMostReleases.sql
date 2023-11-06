CREATE OR REPLACE VIEW MostNewReleasesMonth AS
WITH MonthlyReleaseCounts AS (
    SELECT
        EXTRACT(MONTH FROM date_added) AS release_month,
        COUNT(*) AS release_count
    FROM
        Movies.MovieTvShowFact
    GROUP BY
        release_month
)
SELECT
    release_month,
    release_count
FROM
    MonthlyReleaseCounts
ORDER BY
    release_count DESC
LIMIT 1;