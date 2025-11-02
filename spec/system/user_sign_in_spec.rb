require "rails_helper"

describe 'User Sign In', type: :system do
  it 'is successful' do
    user = create(:user, full_name: 'João da Silva')

    visit(root_path)
    click_on('Sign In')

    within 'form' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
    end

    expect(page).not_to have_link('Sign In')
    expect(page).to have_button('Sign Out')
    expect(page).to have_content("Hello, João")
  end
end
