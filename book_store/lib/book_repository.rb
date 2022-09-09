require 'book'
require 'database_connection'

class BookRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, genre FROM artist;
    all = "SELECT * FROM books;"
    result = DatabaseConnection.exec_params(all, [])
    # return result
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

  def find(id)
    # Executes the SQL query:
    id = "SELECT id, title, author_name FROM books WHERE id = #{id};"
    result = DatabaseConnection.exec_params(id, [])
    book = Book.new
    book.id = result[0]['id']
    book.title= result[0]['title']
    book.author_name = result[0]['author_name']

    return book
    # Returns a single Artist object.
  end

  def create(book)
    create = "INSERT INTO books ( title, author_name) VALUES('#{book.title}', '#{book.author_name}');"
    result = DatabaseConnection.exec_params(create, [])
  end

  def update(book)
    update = "UPDATE books SET title = '#{book.title}', author_name = '#{book.author_name}' WHERE id = '#{book.id}';"
    result = DatabaseConnection.exec_params(update, [])
  end

  def delete(book)
    delete = "DELETE FROM books WHERE id = '#{book.id}';"
    result = DatabaseConnection.exec_params(delete, [])
  end
end