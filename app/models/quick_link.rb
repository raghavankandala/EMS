class QuickLink < ActiveRecord::Base
  attr_accessible :title, :external, :attachment, :external_link

  has_attached_file :attachment 
  
  validates_presence_of :attachment, :unless => Proc.new { |ql| ql.external? }
  validates_attachment_size :attachment, :less_than => 1.megabytes
  validates_attachment_content_type :attachment, :content_type => ['application/pdf', 'application/octetstream']

  validates_presence_of :title
  validates_presence_of :external_link, :if => Proc.new { |ql| ql.external? }
end
