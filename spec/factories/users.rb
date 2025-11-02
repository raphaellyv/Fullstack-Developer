FactoryBot.define do
  factory :user do
    full_name { "João Silva" }
    email { "username@domain.com" }
    role { :no_admin }
  end
end
