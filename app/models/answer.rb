class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :survey_answers
 # belongs_to :ac, :class => 'Constituency', :as => :ac_id
 # belongs_to :pc, :class => 'Constituency', :as => :pc_id
end
