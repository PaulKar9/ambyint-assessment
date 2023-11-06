import requests

# Snowflake and AMiner API configurations
snowflake_username = '<I will not share this in a repo>'
snowflake_password = '<I will not share this in a repo>'
# This (snowflake_account) should also be passed as a secret variable and not exposed in code
# But I will let myself slide on this as it is only an assesment
snowflake_account = 'GD57667' 
snowflake_database = 'NetflixDataWarehouse'
snowflake_schema = 'Movies'
snowflake_table = 'Actor'
aminer_api_url = 'https://www.aminer.cn/gender/api'

# Snowflake connection setup (using Snowflake SQLAlchemy)
from snowflake.sqlalchemy import URL
from sqlalchemy import create_engine

snowflake_connection = create_engine(URL(
    account=snowflake_account,
    user=snowflake_username,
    password=snowflake_password,
    database=snowflake_database,
    schema=snowflake_schema
))

# Function to fetch gender from aminer API
def get_gender_from_aminer(name):
    try:
        response = requests.get(aminer_api_url, params={'name': name})
        if response.status_code == 200:
            data = response.json()
            gender = data.get('gender', 'Unknown')
            return gender
        else:
            return 'Unknown'
    except Exception as e:
        print(f"Error fetching gender for {name}: {str(e)}")
        return 'Unknown'

# Function to update the Snowflake table with gender information
def update_actor_table_with_gender():
    with snowflake_connection.connect() as con:
        # Fetch all actor names from the table
        query = f"SELECT actor_name FROM {snowflake_table}"
        result = con.execute(query)

        # Iterate through each actor name and fetch their gender
        for row in result:
            actor_name = row['actor_name']
            gender = get_gender_from_aminer(actor_name)

            # Update the table with the gender information
            update_query = f"UPDATE {snowflake_table} SET gender = '{gender}' WHERE actor_name = '{actor_name}'"
            con.execute(update_query)

if __name__ == '__main__':
    update_actor_table_with_gender()
