class Song
  attr_accessor :name, :album, :id
  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
  end
  def self.create_table
    DB[:conn].execute(
      "CREATE TABLE IF NOT EXISTS songs (id INTEGER PRIMARY KEY, name TEXT, album TEXT)"
    )
  end
  def save
    # insert the song
    DB[:conn].execute(
      "INSERT INTO songs (name, album) VALUES (?, ?)",
      self.name,
      self.album
    )
    # get the song ID from the database and save it to the Ruby instance
    self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
    # return the Ruby instance
    self
  end
  def self.create(name:, album:)
    Song.new(name: name, album: album).save
  end
end

# Song.create_table
# # []
# DB[:conn].execute("PRAGMA table_info(songs)")
# # [[0, "id", "INTEGER", 0, nil, 1], [1, "name", "TEXT", 0, nil, 0], [2, "album", "TEXT", 0, nil, 0]]

# hello = Song.new(name: "Hello", album: "25")
# # <Song:0x00007fed21935128 @album="25", @id=nil, @name="Hello">

# hello.save
# # []

# ninety_nine_problems = Song.new(name: "99 Problems", album: "The Black Album")
# # <Song:0x00007fed218c6200 @album="The Black Album", @id=nil, @name="99 Problems">

# ninety_nine_problems.save
# # []

# DB[:conn].execute("SELECT * FROM songs;")
# # [[1, "Hello", "25"], [2, "99 Problems", "The Black Album"]]
