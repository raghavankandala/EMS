class CreateSurveyor < ActiveRecord::Migration
  def self.up
    create_table :surveyors do |t|
      t.string :name, :email, :ip_address, :state, :city
      t.integer :ac_id, :pc_id, :survey_id
      t.timestamps
    end
    remove_column "survey_answers", "state"
    remove_column "survey_answers", "city"
    remove_column "survey_answers", "ip_address"
    remove_column "survey_answers", "name"
    remove_column "survey_answers", "email"
    remove_column "survey_answers", "ac_id"
    remove_column "survey_answers", "pc_id"
    add_column "survey_answers", "surveyor_id", :integer
  end

  def self.down
    drop_table :surveyors
    add_column "survey_answers", "state", :string
    add_column "survey_answers", "city", :string
    add_column "survey_answers", "ip_address", :string
    add_column "survey_answers", "name", :string
    add_column "survey_answers", "email", :string
    add_column "survey_answers", "ac_id", :integer
    add_column "survey_answers", "pc_id", :integer
    remove_column "survey_answers", "surveyor_id"
  end
end
