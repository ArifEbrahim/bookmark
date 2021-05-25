require './lib/database_connection.rb'

class Comment 

  attr_reader :id, :text, :bookmark_id

  def initialize(id, text, bookmark_id)
    @id = id
    @text = text
    @bookmark_id = bookmark_id
  end

  def self.create(text, bookmark_id)
    result = DatabaseConnection.query("INSERT INTO comments (bookmark_id, text) VALUES ('#{bookmark_id}','#{text}') RETURNING * ;")
    Comment.new(result[0]['id'], result[0]['text'], result[0]['bookmark_id'])
  end

  def self.where(bookmark_id)
    result = DatabaseConnection.query("SELECT * FROM comments WHERE bookmark_id = #{bookmark_id};")
    result.map do |comment|
      Comment.new(comment['id'], comment['text'], comment['bookmark_id'])
    end
  end

end