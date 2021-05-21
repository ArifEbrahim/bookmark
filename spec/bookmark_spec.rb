require 'bookmark'

RSpec.describe Bookmark do
  describe '.all' do
    it 'returns all saved bookmarks' do
      con = PG.connect(dbname: 'bookmark_manager_test')

      bookmark = Bookmark.create('http://www.makersacademy.com','Makers Academy')
      Bookmark.create('http://www.google.com', 'Google')
      Bookmark.create('http://www.amazon.com', 'Amazon')

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id 
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '.create ' do
    it 'can store a bookmark in the database' do
      bookmark = Bookmark.create('http://www.medium.com','Medium')
      persisted_data = persisted_data(bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq('Medium')
      expect(bookmark.url).to eq('http://www.medium.com')
    end

    it 'does not create a bookmark if url is invalid' do
      Bookmark.create('rubbish','rubbish')
      expect(Bookmark.all).to be_empty
    end

  end

  describe '.delete' do
    it 'can delete a bookmark in the database' do
      bookmark = Bookmark.create('http://www.bbc.co.uk', 'BBC')
      Bookmark.delete(bookmark.id)
      expect(Bookmark.all.length).to eq 0
    end
  end

  describe '.update' do
    it 'can update a bookmark' do
      bookmark = Bookmark.create('http://www.bbc.co.uk', 'BBC')
      updated_bookmark = Bookmark.update('http://www.cnbc.com', 'CNBC', bookmark.id)

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq(bookmark.id)
      expect(updated_bookmark.title).to eq('CNBC')
      expect(updated_bookmark.url).to eq('http://www.cnbc.com')
    end
  end

  describe '.find' do
    it 'can find a specific bookmark' do
      bookmark = Bookmark.create('http://www.bbc.co.uk', 'BBC')
      search_result = Bookmark.find(bookmark.id)

      expect(search_result).to be_a Bookmark
      expect(search_result.id).to eq(bookmark.id)
      expect(search_result.title).to eq('BBC')
      expect(search_result.url).to eq('http://www.bbc.co.uk')

    end
  end




end