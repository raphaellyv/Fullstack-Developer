require "rails_helper"

describe 'Admin edit User', type: :system do
  it 'is acessed through the admin dashboard' do
    admin = create(:user, role: :admin)
    login_as(admin)

    visit(admins_dashboard_path)
    click_on('Edit')

    expect(page).to have_content('Edit User')
    expect(page).to have_field('Full name', with: admin.full_name)
    expect(page).to have_field('Email', with: admin.email)
    expect(page).to have_field('Avatar image')
    expect(page).to have_button('Update')
  end
end
