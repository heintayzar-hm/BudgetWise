class SplashController < ApplicationController
  def index
    return redirect_to user_categories_path(current_user) if user_signed_in?
  end
end
