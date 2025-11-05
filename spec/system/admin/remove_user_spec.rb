require "rails_helper"

describe 'Admin remove user', type: :system do
  it 'is accessed through edit user page' do
    admin = create(:user, role: :admin)
    user = create(:user)
    login_as(admin)

    visit(edit_admin_path(user.id))

    expect(page).to have_content('Remove this user')
    expect(page).to have_button('Remove user')
  end

  it 'removes user from the database' do
    admin = create(:user, role: :admin)
    user = create(:user)
    login_as(admin)

    visit(edit_admin_path(user.id))

    expect(User.count).to eq 2

    click_on('Remove user')
    expect(User.count).to eq(1)
    expect(User.first).to eq(admin)
    expect(page).to have_content('The user has been removed successfully.')
    expect(page).to have_content('Users')
  end

  context 'and they are another admin' do
    it 'removes the admin from the database' do
      admin1 = create(:user, role: :admin)
      admin2 = create(:user, role: :admin)
      login_as(admin1)

      visit(edit_admin_path(admin2.id))

      expect(User.count).to eq 2

      click_on('Remove user')
      expect(User.count).to eq(1)
      expect(User.first).to eq(admin1)
      expect(page).to have_content('The user has been removed successfully.')
      expect(page).to have_content('Users')
    end
  end

  context 'and they are the same admin' do
    context 'and there is another admin' do
      it 'removes the same admin from the database' do
        admin1 = create(:user, role: :admin)
        admin2 = create(:user, role: :admin)
        login_as(admin1)

        visit(edit_admin_path(admin2.id))

        expect(User.count).to eq 2

        click_on('Remove user')
        expect(User.count).to eq(1)
        expect(User.first).to eq(admin1)
        expect(page).to have_content('The user has been removed successfully.')
        expect(page).to have_content('Users')
      end
    end

    context 'and there is not another admin' do
      it 'shows error message' do
        admin = create(:user, role: :admin)
        login_as(admin)

        visit(edit_admin_path(admin.id))
        click_on('Remove user')

        expect(User.count).to eq(1)
        expect(User.first).to eq(admin)
        expect(page).to have_content('In order to remove this user, please create another administrator.')
        expect(page).to have_content('Edit User')
      end
    end
  end
end
