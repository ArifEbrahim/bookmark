# As a user
# So I can change a bookmark in Bookmark Manager
# I want to update a bookmark

feature 'updating a bookmark' do
  scenario 'user can update an existing bookmark' do
    bookmark = Bookmark.create('http://www.bbc.co.uk', 'BBC')
    visit('/bookmarks')
    expect(page).to have_link('BBC', href: 'http://www.bbc.co.uk')

    first('.bookmark').click_button('Edit')
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

    fill_in('url', with: 'http://www.cnbc.com')
    fill_in('title', with: 'CNBC')
    click_button('Submit')

    expect(current_path).to eq('/bookmarks')
    expect(page).not_to have_link('BBC', href: 'http://www.bbc.co.uk')
    expect(page).to have_link('CNBC', href: 'http://www.cnbc.com')
  end
end
