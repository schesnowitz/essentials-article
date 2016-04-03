class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    alias_action :create, :read, :update, :destroy, :to => :crud
    if user.admin?
      can :manage, :all
    else
      can :crud, Article do |article|
        article.user == user
      end
      can :crud, Comment do |comment|
        comment.user == user
      end
      can :read, :all
    end
  end
end