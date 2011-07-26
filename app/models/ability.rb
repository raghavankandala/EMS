class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # Guest User
 
    if user.role? :admin
      can :manage, :all
    else
      can :read, :all
      can [:attend, :attendees, :volunteer, :invite, :send_invite, :register, :confirm_participation, :fetch_attendees], [Event]
      can [:recent], [PressRelease]
      can [:new, :create], [Surveyor]
    end
  end
  
end
