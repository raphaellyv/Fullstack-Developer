class User < ApplicationRecord
  validates :full_name, :email, :role, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  enum :role, { admin: "admin", no_admin: "no_admin" }, default: :no_admin, validate: true
end
