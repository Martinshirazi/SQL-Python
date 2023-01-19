import psycopg2
# connect to your psotgres DB
conn = psycopg2.connect(
    """
    dbname=week3 user=postgres host=localhost port=5432
    """
)

conn.set_session(autocommit=True)
# Auto save our changes to DB

# open a cursor to perform database operations
cur = conn.cursor()

cur.execute(
    """
    DROP TABLE IF EXISTS veggies
    """

)
# Create a veggies table

cur.execute(
    """
    CREATE TABLE veggies(
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        color TEXT NOT NULL
        )
    """
)
# inserting data into our table
cur.execute(
    """
    INSERT INTO veggies VALUES 
    (1, 'carrot', 'orange'),
    (2, 'onion', 'yellow'),
    (3, 'zucchini', 'green'),
    (4, 'squash', 'yellow'),
    (5, 'pepper', 'red'),
    (6, 'onion', 'red')

    """
)

cur.execute(
    """
    SELECT * FROM veggies
    """
)

# retrieve our data
records = cur.fetchall()
# print(records)

cur.execute(
    """
    SELECT color, name FROM veggies
    """
)
veggie_records = cur.fetchall()
for v in veggie_records:
    print(v[0], v[1])

print('')  # new line

cur.execute(
    """
    SELECT color, name FROM veggies ORDER BY name, color
    """
)

veggie_records = cur.fetchall()

for i, v in enumerate(veggie_records):
    print(str(i+1) + ".", v[0].capitalize(), v[1].capitalize())
