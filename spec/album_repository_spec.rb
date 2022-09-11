# file: spec/artist_repository_spec.rb
require 'album_repository'


def reset_album_table
    seed_sql = File.read('spec/seed_artist.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
end
  
describe AlbumRepository do
  before(:each) do 
    reset_album_table
  end

  # (your tests will go here).

  it "should return all" do 
    # Get all artists
    repo = AlbumRepository.new
    artist = repo.all
    expect(artist.length).to eq  6
  end

  it "should find a single album from id" do
    repo = AlbumRepository.new
    album = repo.find(2)
    expect(album.title).to eq "Surfer Rosa"
  end

  it "creates a new album" do
    repo = AlbumRepository.new
    album = Album.new
    album.title = "Bon Voyage"
    album.release_year = "2021"
    album.artist_id = 2
    repo.create(album)
    result = repo.find(7)
    expect(result.title).to eq "Bon Voyage"
    expect(result.release_year).to eq "2021"
    expect(result.artist_id).to eq "2"
  end

  it "should update" do 
    repo = AlbumRepository.new
    album = Album.new
    album = repo.find(3)
    album.title = "Bon Voyage"
    album.release_year = "2021"
    repo.update(album)
    result = repo.find(3)
    expect(result.title).to eq "Bon Voyage"
  end


  it "should delete" do
    repo = AlbumRepository.new
    album = repo.find(2)
    repo.delete(album)
    album = repo.all
    expect(album.length).to eq  5
  end

end