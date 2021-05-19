require 'pg'

class Bookmark

  attr_reader :id, :title, :url

  def initialize(id, title, url) 
    @id = id
    @title = title 
    @url = url
  end 

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'bookmark_manager_test')
    else
      con = PG.connect(dbname: 'bookmark_manager')
    end

    results = con.exec( 'SELECT * FROM bookmarks;' )
    results.map do |bookmark|
      Bookmark.new(bookmark['id'], bookmark['title'], bookmark['url'])
    end
  end

  def self.create(url, title)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'bookmark_manager_test')
    else
      con = PG.connect(dbname: 'bookmark_manager')
    end

    result = con.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, url, title")
    Bookmark.new(result[0]['id'], result[0]['title'], result[0]['url'])
  end
end

