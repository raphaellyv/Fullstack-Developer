require 'rails_helper'

describe 'Edit user', type: :system do
  it 'shows the filled form' do
    user = create(:user)
    login_as(user)

    visit(profile_path)
    click_on('Edit')

    expect(page).to have_content('Edit User')
    expect(page).to have_field('Full name', with: user.full_name)
    expect(page).to have_field('Email', with: user.email)
    expect(page).to have_content("Avatar image (leave blank if you don't want to change it)")
    expect(page).to have_content("Password (leave blank if you don't want to change it)")
    expect(page).to have_content('6 characters minimum')
    expect(page).to have_content('Password confirmation')
    expect(page).to have_content('Current password (we need your current password to confirm your changes)')
  end

  context 'fails' do
    it 'shows error message' do
      user = create(:user)
      login_as(user)

      visit(profile_path)
      click_on('Edit')

      fill_in 'Current password', with: 'password'
      click_on('Update')

      expect(page).to have_content('1 error prohibited this user from being saved:')
      expect(page).to have_content("Current password is invalid")
    end
  end
end
