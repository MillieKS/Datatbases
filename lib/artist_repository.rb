require 'artist'

class ArtistRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      # SELECT id, name, genre FROM artist;
      all = "SELECT * FROM artists;"
      result = DatabaseConnection.exec_params(all, [])
      artists = []
        result.each do |x|
          artist = Artist.new
          artist.id = x['id']
          artist.name = x['name']
          artist.genre = x['genre']
  
          artists << artist
        end
        return artists
  
      # Returns an array of Artist objects.
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
      id = "SELECT id, name, genre FROM artists WHERE id = #{id};"
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
      create = "INSERT INTO artists ( name, genre) VALUES('#{artist.name}', '#{artist.genre}');"
      result = DatabaseConnection.exec_params(create, [])
    end
  
    def update(artist)
      update = "UPDATE artists SET name = '#{artist.name}', genre = '#{artist.genre}' WHERE id = '#{artist.id}';"
      result = DatabaseConnection.exec_params(update, [])
    end
  
    def delete(artist)
      delete = "DELETE FROM artists WHERE id = '#{artist.id}'"
      result = DatabaseConnection.exec_params(delete, [])
    end
  end
