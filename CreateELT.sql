CREATE OR REPLACE STAGE netflix_stage
  FILE_FORMAT = (TYPE = 'CSV')
  URL = 'snowflake://GD57667.snowflakecomputing.com/myStagePath';

CREATE OR REPLACE FILE FORMAT netflix_csv_format
  TYPE = 'CSV'
  SKIP_HEADER = 1;

CREATE OR REPLACE TASK load_netflix_data
  WAREHOUSE = COMPUTE_WH
  SCHEDULE = 'USING CRON 0 0 * * * UTC'
  COMMENT = 'Load netflix_titles.csv data';

-- Define the task's SQL statements
ALTER TASK load_netflix_data
  RESUME;

-- Attach the task to the following SQL statements
CREATE OR REPLACE TABLE IF NOT EXISTS Movies.NetflixRawData AS
SELECT * FROM @netflix_stage/netflix_titles.csv;
