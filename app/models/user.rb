class User < ApplicationRecord
  has_one_attached :avatar_image

  validates :full_name, :email, :role, :avatar_image, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validate :avatar_image_content_type

  enum :role, { admin: "admin", no_admin: "no_admin" }, default: :no_admin, validate: true

  private

  def avatar_image_content_type
    return unless avatar_image.attached?

    unless avatar_image.content_type.in?([ "image/png", "image/jpg", "image/jpeg", "image/avif" ])
      errors.add(:avatar_image, I18n.t("messages.errors.image.content_type"))
    end
  end
end
