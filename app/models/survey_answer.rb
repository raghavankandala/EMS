class SurveyAnswer < ActiveRecord::Base
  belongs_to :answer
  belongs_to :question
  belongs_to :surveyor

  validates_presence_of :answer_id, :question_id, :surveyor_id
end
