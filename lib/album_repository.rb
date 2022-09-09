require 'album'

class AlbumRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      # SELECT id, name, genre FROM artist;
      all = "SELECT * FROM albums;"
      result = DatabaseConnection.exec_params(all, [])
      album = []
        result.each do |x|
          album = Album.new
          album.id = x['id']
          album.title = x['title']
          album.release_year = x['release_year']
          album.artist_id = x['artist_id']
  
          albums << album
        end
      return albums
  
      # Returns an array of Artist objects.
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
      id = "SELECT * FROM artists WHERE id = #{id};"
      result = DatabaseConnection.exec_params(id, [])
      album = Album.new
      album.id = result[0]['id']
      album.title = result[0]['title']
      album.release_year = result[0]['release_year']

  
      return album
      # Returns a single Artist object.
    end
  
    # Add more methods below for each operation you'd like to implement.
  
    def create(album)
      create = "INSERT INTO albums ( title, release_year) VALUES('#{album.title}', '#{album.release_year}');"
      result = DatabaseConnection.exec_params(create, [])
    end
  
    def update(album)
      update = "UPDATE albums SET name = '#{album.title}' WHERE id = '#{album.id}';"
      result = DatabaseConnection.exec_params(update, [])
    end
  
    def delete(album)
      delete = "DELETE FROM albums WHERE id = '#{album.id}'"
      result = DatabaseConnection.exec_params(delete, [])
    end
  end