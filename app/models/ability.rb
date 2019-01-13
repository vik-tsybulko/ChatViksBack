class Ability
  include CanCan::Ability

  def initialize(user)
    user_abilities(user) if user.user?

    admin_abilities(user) if user.admin?
  end

  def user_abilities(user)
    can :manage, User, id: user.id
    can :read, User
    can :manage, ChatRoom, user_id: user.id || new_record?
    can :manage, Message, user_id: user.id || new_record?
  end

  def admin_abilities(user)
    can :manage, :all
  end
end
