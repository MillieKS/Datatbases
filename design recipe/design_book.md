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
class Book
end

# Repository class
# (in lib/artist_repository.rb)
class BookRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/artist.rb)

class Book

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :author_name
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
# Table name: book_store

# Repository class
# (in lib/book_repository.rb)

class BookRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, genre FROM artist;
    all = "SELECT * FROM books;"
    result = DatabaseConnection.exec_params(all, [])
    return result
    books = []
      result.each do |x|
        book = Book.new
        book.id = x['id']
        book.title = x['title']
        book.author_name = x['author_name']

        books << book
      end
      return books

    # Returns an array of Artist objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    id = "SELECT id, title, author_name FROM books WHERE id = #{id};"
    result = DatabaseConnection.exec_params(id, [])
    book = Book.new
    book.id = result[0]['id']
    book.name = result[0]['title']
    book.genre = result[0]['author_name']

    return book
    # Returns a single Artist object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(book)
    create = "INSERT INTO books ( title, author_name) VALUES('#{book.title}', '#{book.author_name}');"
    result = DatabaseConnection.exec_params(create, [])
  end

  def update(book)
    update = "UPDATE books SET title = '#{book.title}' author_name = '#{book.author_name}' WHERE id = '#{book.id}';"
    result = DatabaseConnection.exec_params(update, [])
  end

  def delete(book)
    delete = "DELETE FROM books WHERE id = '#{book.id}';"
    result = DatabaseConnection.exec_params(delete, [])
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

repo = BookRepository.new

book = repo.all

book.length # =>  4

book[0].id # =>  1
book[0].title # =>  'Nineteen Eighty-Four'
book[0].author_name # =>  'George Orwell'

book[1].id # =>  2
book[1].name # =>  
book[1].author_name # =>  

book[2].id # =>  3
book[2].name # =>  
book[2].author_name # =>  

book[3].id # =>  3
book[3].name # =>  
book[3].author_name # =>  

# 2
# Get a single book

repo = BookRepository.new

book = repo.find(1)

book[0].id # =>  1
book[0].title # =>  'Nineteen Eighty-Four'
book[0].author_name # =>  'George Orwell'

# Add more examples for each method

# 3
# create a book
repo = BookRepository.new
book = Book.new
book.title = "Lady Gaga"
book.author_name = "Pop"
repo.create(book)
result = repo.find(5)
result.title # => "Lady Gaga"
result.author_name # => "Pop"

#4
#update an artist
repo = BookRepository.new
book = repo.find(1)
book.title = "Pop"
repo.update(book)
result = repo.find(1)
result.author_name # => "Pop"

# 5
# Delete an artist

repo = BookRepository.new
book = repo.find(4)
book.delete

book = repo.all
book.length # => 3

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/book_repository_spec.rb

def reset_book_table
  seed_sql = File.read('spec/seeds_book.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store' })
  connection.exec(seed_sql)
end

describe BookRepository do
  before(:each) do 
    reset_book_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

