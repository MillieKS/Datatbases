# file: app.rb

require_relative 'lib/database_connection'
# require_relative 'lib/book_repository'


# We need to give the database name to the method `connect`.
DatabaseConnection.connect('book_store_test')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT * FROM books;'
# 'SELECT id, title, author_name FROM books;'
result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
result.each do | x|
p x
end
# books = BookRepository.new
# result = books.all
# result.each {|result|
 #   p "#{result.id} - #{result.title} - #{result.author_name}"
#}