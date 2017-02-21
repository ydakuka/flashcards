class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, I18n.t(:not_authorized_raise) unless user.has_role? :admin
    @user = user
    @record = record
  end

  %w(index? show? create? update? destroy?).each do |name|
    define_method name do
      true
    end
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
