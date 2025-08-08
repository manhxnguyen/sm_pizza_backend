class DashboardPolicy
  attr_reader :user, :dashboard

  def initialize(user, dashboard)
    @user = user
    @dashboard = dashboard
  end

  def index?
    # All authenticated users can view dashboard
    user.present?
  end
end
