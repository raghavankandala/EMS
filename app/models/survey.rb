class Survey < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true

  has_many :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true
end