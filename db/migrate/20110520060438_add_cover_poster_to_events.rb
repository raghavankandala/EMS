class AddCoverPosterToEvents < ActiveRecord::Migration
  def self.up
    add_column "events", "cover_poster_content_type", :string
    add_column "events", "cover_poster_file_name", :string
    add_column "events", "cover_poster_file_size", :integer
  end

  def self.down
    remove_column "events", "cover_poster_content_type"
    remove_column "events", "cover_poster_file_name"
    remove_column "events", "cover_poster_file_size"
  end
end
