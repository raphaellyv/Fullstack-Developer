require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:role) }

    it { should validate_uniqueness_of(:email) }

    it {
      should define_enum_for(:role).with_values({
        admin: "admin", no_admin: "no_admin"
      }).backed_by_column_of_type(:enum)
    }

    it 'validates the email format' do
      user1 = build(:user, email: 'usernamedomain.com')
      user2 = build(:user, email: 'username@@domain.com')
      user3 = build(:user, email: 'user name@domain.com')
      user4 = build(:user, email: 'user@domain..com')
      user5 = build(:user, email: '.user@domain.com')

      user1.valid?
      user2.valid?
      user3.valid?
      user4.valid?
      user5.valid?

      expect(user1.errors[:email]).to include("is invalid")
      expect(user2.errors[:email]).to include("is invalid")
      expect(user3.errors[:email]).to include("is invalid")
      expect(user4.errors[:email]).to include("is invalid")
      expect(user5.errors[:email]).to include("is invalid")
    end
  end
end
