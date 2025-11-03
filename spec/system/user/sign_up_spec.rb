require "rails_helper"

describe 'User Sign Up', type: :system do
  context 'success' do
    xit 'shows user first name and sign out option' do
      user = create(:user)

      visit(root_path)
      click_on('Sign In')

      within 'form' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_on('Sign in')
      end

      expect(page).not_to have_link('Sign In')
      expect(page).to have_link('Profile')
      expect(page).to have_button('Sign Out')
      expect(page).to have_content("Signed in successfully.")
      expect(page).to have_content(user.full_name)
      expect(page).to have_content(user.email)
    end
  end

  context 'fails' do
    it 'shows error message' do
      visit(root_path)
      click_on('Sign In')
      click_on('Sign up')

      within 'form' do
        click_on('Sign up')
      end

      expect(page).to have_content('4 errors prohibited this user from being saved:')
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("Full name can't be blank")
      expect(page).to have_content("Avatar image can't be blank")
    end
  end
end
