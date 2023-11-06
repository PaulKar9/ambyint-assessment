CREATE OR REPLACE VIEW LargestYOYIncreaseYear AS
WITH TVShowCounts AS (
    SELECT
        release_year,
        COUNT(*) AS tv_show_count
    FROM
        Movies.MovieTvShowFact
    WHERE
        type = 'TV Show'
    GROUP BY
        release_year
)
SELECT
    release_year,
    tv_show_count,
    LAG(tv_show_count) OVER (ORDER BY release_year) AS prev_year_tv_show_count,
    CASE
        WHEN LAG(tv_show_count) OVER (ORDER BY release_year) = 0 THEN NULL
        ELSE (tv_show_count - LAG(tv_show_count) OVER (ORDER BY release_year)) / LAG(tv_show_count) OVER (ORDER BY release_year) * 100
    END AS yoy_increase_percentage
FROM
    TVShowCounts
ORDER BY
    yoy_increase_percentage DESC
LIMIT 1;