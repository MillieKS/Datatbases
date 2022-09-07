# file: spec/artist_repository_spec.rb
require 'artist_repository'


def reset_artist_table
    seed_sql = File.read('spec/seeds_artist.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library' })
    connection.exec(seed_sql)
  end
  
  describe ArtistRepository do
    before(:each) do 
      reset_artist_table
    end
  
    # (your tests will go here).

    it "should return all" do 
      # Get all artists
      repo = ArtistRepository.new
      artist = repo.all
      expect(artist.length).to eq  2
    end

    it "should find a single artist from id" do
      repo = ArtistRepository.new
      artist = repo.find(2)
      expect(artist.name).to eq "Abba"
    end

    it "creates a new artist" do
      repo = ArtistRepository.new
      artist = Artist.new
      artist.name = "Lady Gaga"
      artist.genre = "Pop"
      repo.create(artist)
      result = repo.find(3)
      expect(result.name).to eq "Lady Gaga"
      expect(result.genre).to eq "Pop"
    end

    it "should update" do 
      repo = ArtistRepository.new
      artist = Artist.new
      artist = repo.find(2)
      artist.name = "Lady Gaga"
      artist.genre = "Pop"
      repo.update(artist)
      result = repo.find(2)
      expect(result.name).to eq "Lady Gaga"
    end


    it "should delete" do
      repo = ArtistRepository.new
      artist = repo.find(2)
      repo.delete(artist)
      artist = repo.all
      expect(artist.length).to eq  1
    end

  end