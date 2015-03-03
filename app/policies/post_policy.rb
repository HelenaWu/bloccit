class PostPolicy < ApplicationPolicy
  def index?
    true
  end
  class Scope < Scope
    def resolve
      if user && (user.admin? || user.moderator?)
        scope.all
      else
        scope.where(:user => user)
      end
    end

  end

end
