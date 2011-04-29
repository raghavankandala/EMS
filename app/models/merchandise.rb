class Merchandise < ActiveRecord::Base
  attr_accessible :title, :cover_image, :material, :event_id
  belongs_to :event

  has_attached_file :cover_image, :styles => { :thumb => "100x100#", :small => "250x244>" }
  has_attached_file :material

  validates_presence_of :title
  validates_presence_of :cover_image

  validates_attachment_size :cover_image, :less_than => 1.megabytes
  validates_attachment_content_type :cover_image, :content_type => ['image/jpeg', 'image/png']

  validates_attachment_size :material, :less_than => 1.megabytes
  validates_attachment_content_type :material, :content_type => ['application/pdf', 'application/octetstream']

  def material_link
   self.material.url.match(/missing.png$/).nil? ? self.material.url : self.cover_image.url
  end
  
  def material_uploaded?
    self.material.url.match(/missing.png$/).nil?
  end

end
