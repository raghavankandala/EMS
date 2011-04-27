class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # Guest User
 
    if user.role? :admin
      can :manage, :all
    else
      can :read, :all
      can [:confirm_participation], [Event]
    end
  end
  
end
