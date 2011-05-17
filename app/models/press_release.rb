class PressRelease < ActiveRecord::Base
  attr_accessible :title, :content, :pr_date, :external, :url, :source
end
