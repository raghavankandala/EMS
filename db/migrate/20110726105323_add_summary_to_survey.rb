class AddSummaryToSurvey < ActiveRecord::Migration
  def self.up
    add_column "surveys", "summary", :text
  end

  def self.down
    remove_column "surveys", "summary"
  end
end
