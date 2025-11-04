class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def dashboard
    @total_users = User.count
    @total_admins = User.admin.count
    @total_no_admins = User.no_admin.count
    @users = User.all.order(:full_name)
  end

  private

  def check_admin
    unless current_user.admin?
      redirect_to root_url, alert: t("messages.errors.restricted_area")
    end
  end
end
