require "rails_helper"

describe 'Edit user', type: :request do
  context 'before login' do
    it 'fails' do
      admin = create(:user, role: :admin, full_name: 'Abel A', email: 'a@email.com')

      patch(admin_path(admin.id), params: { user: { full_name: 'Abel B', email: 'b@email.com' } })

      expect(response).to redirect_to(new_user_session_url)
    end
  end
end