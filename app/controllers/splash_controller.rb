class SplashController < ApplicationController
  def index
    return redirect_to groups_path if user_signed_in?
  end
end
