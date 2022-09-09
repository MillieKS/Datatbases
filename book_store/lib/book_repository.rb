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
end