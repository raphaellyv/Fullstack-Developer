require "rails_helper"

describe 'Homepage', type: :system do
  it 'shows app name and welcome message' do
    visit(root_path)

    expect(page).to have_link('Users Management App')
    expect(page).to have_content('Welcome, folks!')
  end
end
