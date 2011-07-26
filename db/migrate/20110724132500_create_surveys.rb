class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.string :title
      t.text :description
      t.date :starts_on
      t.date :ends_on
      t.timestamps
    end

    create_table :questions do |t|
      t.string :title
      t.integer :survey_id
      t.timestamps
    end

    create_table :answers do |t|
      t.string :title
      t.integer :question_id
      t.integer :votes, :default => 0
      t.timestamps
    end

    create_table :survey_answers do |t|
      t.integer :answer_id, :question_id
      t.string :state, :city, :ip_address
      t.string :name, :email
      t.integer :pc_id, :ac_id
      t.timestamps
    end
  end

  def self.down
    drop_table :surveys
    drop_table :questions
    drop_table :answers
    drop_table :survey_answers
  end
end
