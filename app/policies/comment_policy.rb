class CommentPolicy < ApplicationPolicy
  def destroy?
    user.present? && (record.user == user || user.admin? || user.moderator?)

  def new?
    create?
  end

  def create?
    user.present?
  end

end