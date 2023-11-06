import pandas as pd
import random

# Load the existing CSV file
my_existing_data = pd.read_csv('netflix_titles.csv')

# Create new records with fictitious data
my_new_records = [
    {
        "show_id": "N1",
        "type": "Movie",
        "title": "myNewMovie1",
        "director": "myNewDirector1",
        "cast": "myNewActor1, myNewActor2",
        "country": "myNewCountry",
        "date_added": "2023-11-06",
        "release_year": 2023,
        "rating": "myNewRating",
        "duration": "120 min",
        "listed_in": "myNewGenre1, myNewGenre2",
        "description": "myNewDescription1",
    },
    {
        "show_id": "N2",
        "type": "TV Show",
        "title": "myNewTVShow1",
        "director": "myNewDirector2",
        "cast": "myNewActor3, myNewActor4",
        "country": "myNewCountry",
        "date_added": "2023-11-06",
        "release_year": 2023,
        "rating": "myNewRating",
        "duration": "5 Seasons",
        "listed_in": "myNewGenre3, myNewGenre4",
        "description": "myNewDescription2",
    }
]

# Update existing records
my_existing_data.loc[my_existing_data['show_id'] == 's1', 'title'] = "myUpdatedTitle1"
my_existing_data.loc[my_existing_data['show_id'] == 's2', 'title'] = "myUpdatedTitle2"

# Combine records
my_combined_data = pd.concat([my_existing_data, pd.DataFrame(my_new_records)])

# Save the combined data to a new CSV file
my_combined_data.to_csv('new_netflix_data.csv', index=False)

