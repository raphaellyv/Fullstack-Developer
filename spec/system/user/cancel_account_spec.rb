require "rails_helper"

describe 'Cancel users account' do
  xit 'is accessed through edit user page' do
    user1 = create(:user)
    user2 = create(:user)
    # login_as(user1)

    # visit(root_path)
    # click_on('Edit')

    # expect(page).to have_button('Cancel my account')
    expect(user1.full_name).to eq('Back')
  end
end