require "rails_helper"

describe 'User profile', type: :system do
  context 'after login' do
    it 'shows user information' do
      user = create(:user, full_name: 'João da Silva', email: 'jsilva@email.com')

      visit(root_path)
      click_on('Sign In')

      within 'form' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_on('Sign in')
      end

      within 'nav' do
        click_on('Profile')
      end

      expect(page).to have_content('João da Silva')
      expect(page).to have_content('jsilva@email.com')
    end
  end

  context 'before login' do
    it 'redirects to sign in' do
      user = create(:user, full_name: 'João da Silva', email: 'jsilva@email.com')

      visit(profile_path)

      expect(page).to have_content('Please sign in to proceed.')
      expect(page).to have_button('Sign in')
      expect(page).not_to have_content('João da Silva')
      expect(page).not_to have_content('jsilva@email.com')
    end
  end
end
