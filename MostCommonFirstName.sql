CREATE OR REPLACE VIEW MostCommonFirstName AS
WITH FirstNameCounts AS (
    SELECT
        SPLIT_PART(actor_name, ' ', 1) AS first_name,
        COUNT(*) AS count
    FROM
        Movies.Actor
    WHERE
        CHAR_LENGTH(actor_name) > 0
    GROUP BY
        first_name
)
SELECT
    first_name,
    count
FROM
    FirstNameCounts
ORDER BY
    count DESC
LIMIT 1;