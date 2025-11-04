class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def dashboard
    @total_users = User.count
    @total_admins = User.admin.count
    @total_no_admins = User.no_admin.count
    @users = User.all.order(:full_name)
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_dashboard_url, notice: t("messages.user_update_success")
    end
  end

  private

  def check_admin
    unless current_user.admin?
      redirect_to root_url, alert: t("messages.errors.restricted_area")
    end
  end

  def user_params
    params.expect(user: [ :full_name, :id, :email, :avatar_image ])
  end
end
