require './lib/database_connection.rb'
require './lib/comment.rb'

class Bookmark

  attr_reader :id, :title, :url

  def initialize(id, title, url) 
    @id, @title, @url = id, title, url
  end 

  def self.all
    results = DatabaseConnection.query( 'SELECT * FROM bookmarks;' )
    results.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['title'], bookmark['url']) }
  end

  def self.create(url, title)
    return false unless valid_url?(url)
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, url, title")
    Bookmark.new(result[0]['id'], result[0]['title'], result[0]['url'])
  end

  def self.delete(id)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{'id'}")
  end

  def self.update(url, title, id)
    result = DatabaseConnection.query("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = '#{id}' RETURNING id, url, title")
    Bookmark.new(result[0]['id'], result[0]['title'], result[0]['url'])
  end

  def self.find(id)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id};")
    Bookmark.new(result[0]['id'], result[0]['title'], result[0]['url'])
  end

  def comments(comment_class = Comment)
    comment_class.where(@id)
  end

  private

  def self.valid_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

end

