class PagesController < ApplicationController
  before_action :authenticate_user!, except: [ :home ]

  def home
  end

  def profile
  end

  def dashboard
    check_admin
    @users = User.all.order(:full_name)
  end

  private

  def check_admin
    unless current_user.admin?
      redirect_to root_url, alert: t("messages.errors.restricted_area")
    end
  end
end
