# As a user
# So that I can make interesting notes
# I want to add a Comment to a Bookmark

feature 'adding and viewing comments' do
  feature 'a user can add and then view a comment' do
    scenario 'a comment is added to a bookmark' do
      bookmark = Bookmark.create('http://www.bbc.co.uk', 'BBC')
      visit '/bookmarks'
      first('.bookmark').click_button 'Add comment'

      expect(current_path).to eq "/bookmarks/#{bookmark.id}/comments/new"

      fill_in 'comment', with: 'This is a test'
      click_button 'Submit'

      expect(current_path).to eq('/bookmarks')
      expect(first('.bookmark')).to have_content 'This is a test'
    end
  end
end