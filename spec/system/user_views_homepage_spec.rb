require "rails_helper"

describe 'User views homepage', type: :system do
  it 'shows app name' do
    visit(root_path)

    expect(page).to have_content('Users Management App')
    expect(page).to have_content('Welcome, folks!')
  end
end
