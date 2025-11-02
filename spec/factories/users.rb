FactoryBot.define do
  factory :user do
    full_name { "João Silva" }
    email { "username@domain.com" }
    role { :no_admin }
    password { "123456" }

    after(:build) do |user|
      user.avatar_image.attach(
        io: File.open(Rails.root.join("spec", "fixtures", "files", "avatar_image.jpg")),
        filename: "avatar_image.jpg",
        content_type: "image/jpg"
      )
    end
  end
end
