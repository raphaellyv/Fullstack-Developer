require "csv"
require "down"

class CsvImportService
  def initialize(file)
    @file = file
    @count = 0
  end

  def import
    @count = 0

    CSV.foreach(@file.path, headers: true) do |row|
      user_hash = row.to_hash
      user = User.new(full_name: user_hash["full_name"], email: user_hash["email"])
      
      image_url = user_hash["avatar_image_url"]
      if image_url
        tempfile = Down.download(image_url)
        user.avatar_image.attach(
          io: tempfile,
          filename: tempfile.original_filename,
          content_type: tempfile.content_type
        )
      end

      @count += 1 if user.save
    end
  end

  def number_imported_with_last_run
    @count
  end
end
