require 'book_repository'


def reset_book_table
    seed_sql = File.read('spec/seeds_book_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
    connection.exec(seed_sql)
end
  
  describe BookRepository do
    before(:each) do 
      reset_book_table
    end
  
    # (your tests will go here).
    it "should return all" do 
      # Get all artists
      repo = BookRepository.new
      book = repo.all
      expect(book.length).to eq  3
    end

    it "should find a single artist from id" do
      repo = BookRepository.new
      book = repo.find(2)
      expect(book.title).to eq "Emma"
    end

    it "creates another book" do
      repo = BookRepository.new
      book = Book.new
      book.title = "The Power of Now"
      book.author_name = "Ekhart Toille"
      repo.create(book)
      result = repo.find(4)
      expect(result.title).to eq "The Power of Now"
      expect(result.author_name).to eq "Ekhart Toille"
    end

    it "updates a book" do
      repo = BookRepository.new
      book = repo.find(2)
      book.title = "Pride and Prejudice"
      # book.author_name = "Jane Austen"
      # book.id = 2
      repo.update(book)
      result = repo.find(2)
      expect(result.title).to eq "Pride and Prejudice"
    end

    it "deletes a book using book id" do
      repo = BookRepository.new
      book = Book.new
      book.id = 2
      repo.delete(book)
      result = repo.all
      expect(result.length).to eq 2
    end 
  end