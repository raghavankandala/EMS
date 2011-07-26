class Surveyor < ActiveRecord::Base
  has_many :survey_answers, :dependent => :destroy
  belongs_to :survey

  validates_presence_of :name, :email
  validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i, :message => "address format is invalid", :unless => Proc.new { |c| c.email.blank? }

  def answered_all?(answers_hash)
    if answers_hash.nil?
      self.errors.add(:base, "Please select your opinion for all the questions")
      return false
    end
    unless self.survey.questions.length == answers_hash.length
      self.errors.add(:base, "Please select your opinion for all the questions")
      return false
    end
    return true
  end

end
