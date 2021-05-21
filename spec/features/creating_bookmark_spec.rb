feature 'create bookmark' do
  # As a user
  # So i can visit websites quickly 
  # I want to create a bookmark for later use
  scenario 'user can create a bookmark' do
    visit('/bookmarks/new')
    fill_in('url', with: 'http://www.medium.com')
    fill_in('title', with: 'Medium')
    click_button('Submit')
    expect(page).to have_link("Medium", href: "http://www.medium.com")
  end

  # As a user
  # So that the bookmarks I save are useful
  # I want to only save a valid URL
  scenario 'user entered url must be valid' do
    visit('/bookmarks/new')
    fill_in('url', with: 'rubbish')
    fill_in('title', with: 'Medium')
    click_button('Submit')
    expect(page).not_to have_content('rubbish')
    expect(page).to have_content('You must submit a valid url')
  end
end