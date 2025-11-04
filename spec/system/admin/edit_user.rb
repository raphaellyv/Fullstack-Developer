require "rails_helper"

describe 'Admin edit User', type: :system do
  it 'is acessed through the admin dashboard' do
    admin = create(:user, role: :admin)
    login_as(admin)

    visit(dashboard_path)

    expect(page).to have_content(admin.full_name)
    expect(page).to have_link('Edit')
  end
end