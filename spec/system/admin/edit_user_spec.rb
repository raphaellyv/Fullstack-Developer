require "rails_helper"

describe 'Admin edit user', type: :system do
  it 'is acessed through the admin dashboard' do
    admin = create(:user, role: :admin)
    login_as(admin)

    visit(admin_dashboard_path)
    click_on('Edit')

    expect(page).to have_content('Edit User')
    expect(page).to have_field('Full name', with: admin.full_name)
    expect(page).to have_field('Email', with: admin.email)
    expect(page).to have_field('Avatar image')
    expect(page).to have_button('Update')
  end

  it 'updates the user information' do
    admin = create(:user, role: :admin, full_name: 'Abel A', email: 'a@email.com')
    login_as(admin)

    visit(admin_dashboard_path)
    click_on('Edit')
    fill_in 'Full name', with: 'Abel B'
    fill_in 'Email', with: 'b@email.com'
    click_on('Update')

    expect(page).to have_content('Abel B')
    expect(page).to have_content('b@email.com')
    expect(page).not_to have_content('Abel A')
    expect(page).not_to have_content('a@email.com')
  end
end
