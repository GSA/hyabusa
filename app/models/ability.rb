class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :super_admin
      can :manage, :all
      # putting this next line here, redundant but significant
      can :manage, ProfileSectionAuthorization
    end

    if user.has_role? :agency_admin
      can [:create, :read, :update], ProfileSection
      can [:create, :read, :update], ProfileField
      can [:create, :read, :update], Profile
    end

    if user.has_role? :agency
      can :read, ProfileSection
      can :read, ProfileField
      can :manage, Profile
    end

    if user.has_role? :user
      can :manage, Profile
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
