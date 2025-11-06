require 'faker'

FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email { "#{ Faker::Alphanumeric.alpha(number: 10) }@domain.com" }
    role { :no_admin }
    password { "123456" }

    after(:build) do |user|
      user.avatar_image.attach(
        io: File.open(Rails.root.join("public", "icon.png")),
        filename: "icon.png",
        content_type: "image/png"
      )
    end
  end
end
