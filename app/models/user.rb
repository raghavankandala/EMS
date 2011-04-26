class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  attr_accessor :password  
  before_save :encrypt_password

  validates_confirmation_of :password  
  validates_presence_of :password, :on => :create  
  validates_presence_of :email  
  validates_uniqueness_of :email 

  has_and_belongs_to_many :roles

   def encrypt_password  
    if password.present?  
      self.password_salt = BCrypt::Engine.generate_salt  
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)  
    end  
  end  

  def self.authenticate(email, password)  
    user = find_by_email(email)  
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)  
      user  
    else  
      nil  
    end  
  end  

  def has_role(role)
    self.roles << Role.find_by_name(role)
    self.save
  end

  def has_role?(role)
    self.roles.map(&:name).include?(role)
  end

  def has_no_role(role)
    self.roles = self.roles.collect { |r| r unless r.name.eql?(role) }.compact
    self.save
  end

  def uroles
    roles.collect {|r| r.name }
  end

  def role?(role)
    uroles.include? role.to_s
  end

end
