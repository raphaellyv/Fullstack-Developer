require "rails_helper"

describe 'User Sign Up', type: :system do
  context 'success' do
    it 'shows user first name and sign out option' do
      visit(root_path)
      click_on('Sign In')
      click_on('Sign up')

      within 'form' do
        fill_in 'Full name', with: 'João da Silva'
        fill_in 'Email', with: 'jsilva@email.com'
        fill_in 'Password', with: '123456'
        fill_in 'Password confirmation', with: '123456'
        page.attach_file('Avatar image', Rails.root.join('spec', 'fixtures', 'files', 'avatar_image.jpg'))
        click_on('Sign up')
      end

      expect(page).not_to have_link('Sign In')
      expect(page).to have_link('Profile')
      expect(page).to have_button('Sign Out')
      expect(page).to have_content('Welcome! You have signed up successfully.')
      expect(page).to have_content('João da Silva')
      expect(page).to have_content('jsilva@email.com')
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
