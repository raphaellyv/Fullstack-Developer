class PagesController < ApplicationController
  def home
  end

  def profile
    unless current_user
      redirect_to new_user_session_path, alert: I18n.t("devise.sign_in.alert")
    end
  end
end
