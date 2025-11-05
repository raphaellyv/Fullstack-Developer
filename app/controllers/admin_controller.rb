class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def dashboard
    @total_users = User.count
    @total_admins = User.admin.count
    @total_no_admins = User.no_admin.count
    @users = User.all.order(:full_name)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_dashboard_url, notice: t("messages.user_create_success")
    else
      render "new"
    end
  end

  def edit
    @roles_options = User.roles.keys
    set_user
  end

  def update
    set_user

    if @user.update(user_params)
      redirect_to admin_dashboard_url, notice: t("messages.update_user_success"), status: :see_other
    else
      @roles_options = User.roles.keys
      render "edit"
    end
  end

  def destroy
    set_user
    @user.destroy!
    redirect_to admin_dashboard_url, notice: t("messages.destroy_user_success"), status: :see_other
  end

  private

  def check_admin
    unless current_user.admin?
      redirect_to root_url, alert: t("messages.errors.restricted_area")
    end
  end

  def user_params
    params.expect(user: [ :full_name, :id, :email, :avatar_image, :role ])
  end

  def set_user
    @user = User.find(params[:id])
  end
end
