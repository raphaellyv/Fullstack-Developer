require "csv"
require "down"

class CsvImportService
  def initialize(file)
    @file = file
    @count = 0
  end

  def import_users
    @count = 0
    total_users_before_import = User.count
    users_to_import = []

    CSV.foreach(@file.path, headers: true) do |row|
      image_url = row["avatar_image_url"]

      if image_url.present?
        user = User.new(full_name: row["full_name"], email: row["email"])

        tempfile = Down.download(image_url)
        user.avatar_image.attach(
          io: tempfile,
          filename: tempfile.original_filename,
          content_type: tempfile.content_type
        )

        users_to_import << user
      end
    end

    User.import users_to_import, on_duplicate_key_ignore: true

    total_users_after_import = User.count
    @count = total_users_after_import - total_users_before_import
  end

  def number_imported_with_last_run
    @count
  end
end
