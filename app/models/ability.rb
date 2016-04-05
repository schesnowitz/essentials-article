class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :update, Article do |article|
        article.user == user
      end
      can :destroy, Article do |article|
        article.user == user
      end      
      can :update, Comment do |comment|
        comment.user == user
      end
      can :destroy, Comment do |comment|
        comment.user == user
      end    
      can :read, :all
    end
  end
end