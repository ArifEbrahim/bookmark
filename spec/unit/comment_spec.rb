require './spec/database_helpers.rb'
require 'comment'
require 'bookmark'

RSpec.describe Comment do
  describe '.create' do
    it 'creates a new comment' do
      bookmark = Bookmark.create('http://www.bbc.co.uk', 'BBC')
      comment = Comment.create('This is a test', bookmark.id)

      persisted_data = persisted_data('comments', comment.id)

      expect(comment).to be_a Comment
      expect(comment.id).to eq persisted_data['id']
      expect(comment.text).to eq 'This is a test'
      expect(comment.bookmark_id).to eq(bookmark.id)
    end
  end

  describe '.where' do
    it 'gets the relevant comments from the databse' do
      bookmark = Bookmark.create("http://www.makersacademy.com", "Makers Academy")
      Comment.create('This is a test comment', bookmark.id)
      Comment.create('This is a second test comment', bookmark.id)
  
      comments = Comment.where(bookmark.id)
      comment = comments.first
      persisted_data = persisted_data('comments', comment.id)
  
      expect(comments.length).to eq 2
      expect(comment.id).to eq persisted_data['id']
      expect(comment.text).to eq 'This is a test comment'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end
end