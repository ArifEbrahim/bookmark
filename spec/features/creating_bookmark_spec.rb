# As a user
# So i can visit websites quickly 
# I want to create a bookmark for later use

feature 'create bookmark' do
  scenario 'user can create a bookmark' do
    visit('/bookmarks/new')
    fill_in('url', with: 'http://www.medium.com')
    fill_in('title', with: 'Medium')
    click_button('Submit')
    expect(page).to have_link("Medium", href: "http://www.medium.com")
  end
end