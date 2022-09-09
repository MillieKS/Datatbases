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
  end