# As a time-pressed user
# So that I can quickly go to web sites I regularly visit
# I would like to see a list of bookmarks

feature 'viewing bookmarks' do
  scenario 'user can see saved bookmarks' do
    Bookmark.create('http://www.makersacademy.com', 'Makers Academy')
    Bookmark.create('http://www.amazon.com', 'Amazon')
    Bookmark.create('http://www.google.com', 'Google')

    visit('/bookmarks')
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    expect(page).to have_link('Amazon', href: 'http://www.amazon.com')
    expect(page).to have_link('Google', href: 'http://www.google.com')
  end
end