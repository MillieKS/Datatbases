# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO artist (name, genre) VALUES ('Pixie', 'Rock');
INSERT INTO artist (name, genre) VALUES ('Abba', 'Pop');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/artist.rb)
class Artist
end

# Repository class
# (in lib/artist_repository.rb)
class ArtistRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/artist.rb)

class Artist

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :genre
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# artist = Artist.new
# artist.name = 'Jo'
# artist.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class ArtistRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, genre FROM artist;
    all = "SELECT * FROM artist;"
    result = DatabaseConnection.exec_params(all, [])
    return result
    artists = []
      result.each do |x|
        artist = Artist.new
        artist.id = x['id']
        artist.name = x['name']
        artist.genre = i['genre']

        artists << artist
      end
      return artists

    # Returns an array of Artist objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    id = "SELECT id, name, genre FROM artist WHERE id = #{id};"
    result = DatabaseConnection.exec_params(id, [])
    artist = Artist.new
    artist.id = result[0]['id']
    artist.name = result[0]['name']
    artist.genre = result[0]['genre']

    return artist
    # Returns a single Artist object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(artist)
    create = "INSERT INTO artist ( name, genre) VALUES('#{artist.name}', #{artist.genre}');"
    result = DatabaseConnection.exec_params(create, [])
  end

  def update(artist)
    update = "UPDATE artist SET name = '#{artist.name}' genre = '#{artist.genre}' WHERE id = '#{artist.id}';"
    esult = DatabaseConnection.exec_params(update, [])
  end

  def delete(artist)
    delete = "DELETE
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all artists

repo = ArtistRepository.new

artist = repo.all

artist.length # =>  2

students[0].id # =>  1
students[0].name # =>  'Pixies'
students[0].genre # =>  'Rock'

students[1].id # =>  2
students[1].name # =>  'Abba'
students[1].cohort_name # =>  'Pop'

# 2
# Get a single artist

repo = StudentRepository.new

student = repo.find(1)

artist.id # =>  1
artist.name # =>  'Pixies'
artist.genre # =>  'Rock'

# Add more examples for each method

# 3
# create a artist
repo = ArtistRepository.new
artist = Artist.new
artist.name = "Lady Gaga"
artist.genre = "Pop"
repo.create(artist)
result = repo.find(3)
result.name # => "Lady Gaga"
result.genre # => "Pop"

#4
#update an artist
repo = ArtistRepository.new
artist = repo.find(0)
artist.genre = "Pop"
repo.update(artist)
result = repo.find(1)
result.genre # => "Pop"

# 5
# Delete an artist

repo = ArtistRepository.new
artist = repo.find(2)
artist.delete

artist = repo.all
artist.length # => 1

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/artist_repository_spec.rb

def reset_artist_table
  seed_sql = File.read('spec/seeds_artist.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library' })
  connection.exec(seed_sql)
end

describe ArtistRepository do
  before(:each) do 
    reset_srtist_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->