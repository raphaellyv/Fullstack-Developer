require "rails_helper"

describe 'User views homepage', type: :system do
  it 'shows app name' do
    visit('/')

    expect(page).to have_content('Users Management App')
  end
end
