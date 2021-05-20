# As a user
# So I can remove my bookmark from Bookmark Manager
# I want to delete a bookmark

feature 'delete bookmark' do
  scenario 'user can delete bookmark' do
    Bookmark.create('http://www.bbc.co.uk', 'BBC')
    visit('/bookmarks')
    expect(page).to have_link("BBC", href: "http://www.bbc.co.uk")

    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link("BBC", href: "http://www.bbc.co.uk")
  end
end