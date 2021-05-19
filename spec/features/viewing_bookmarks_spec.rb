# As a time-pressed user
# So that I can quickly go to web sites I regularly visit
# I would like to see a list of bookmarks

require 'pg'

feature 'viewing bookmarks' do
  scenario 'user can see saved bookmarks' do
    Bookmark.create('http://www.makersacademy.com', 'Makers Academy')
    Bookmark.create('http://www.amazon.com', 'Amazon')
    Bookmark.create('http://www.google.com', 'Google')

    visit('/')
    click_button('View')
    expect(page).to have_content('Google')
    expect(page).to have_content('Makers Academy')
    expect(page).to have_content('Amazon')
  end
end