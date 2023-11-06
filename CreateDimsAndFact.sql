-- Creating Dimensions
CREATE TABLE IF NOT EXISTS Movies.Genre (
    genre_id STRING PRIMARY KEY,
    genre_name STRING
);

CREATE TABLE IF NOT EXISTS Movies.Director (
    director_id STRING PRIMARY KEY,
    director_name STRING
);

CREATE TABLE IF NOT EXISTS Movies.Actor (
    actor_id STRING PRIMARY KEY,
    actor_name STRING
);

CREATE TABLE IF NOT EXISTS Movies.Country (
    country_id STRING PRIMARY KEY,
    country_name STRING
);

CREATE TABLE IF NOT EXISTS Movies.TvRating (
    rating_id STRING PRIMARY KEY,
    tv_rating STRING
);

-- Creating a fact table
CREATE TABLE IF NOT EXISTS Movies.MovieTvShowFact (
    show_id STRING PRIMARY KEY,
    type STRING,
    title STRING,
    date_added DATE,
    release_year INTEGER,
    duration STRING,
    description STRING,
    genre_id STRING,
    director_id STRING,
    rating_id STRING,
    country_id STRING,
    FOREIGN KEY (genre_id) REFERENCES Movies.Genre (genre_id),
    FOREIGN KEY (director_id) REFERENCES Movies.Director (director_id),
    FOREIGN KEY (rating_id) REFERENCES Movies.TvRating (rating_id),
    FOREIGN KEY (country_id) REFERENCES Movies.Country (country_id)
)
CLUSTER BY (genre_id);