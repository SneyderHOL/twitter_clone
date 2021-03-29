class ApplicationController < ActionController::Base
  protected
  
  def after_sign_in_path_for(resource)
    user_path(current_user.username)
  end

  def render_not_found
    render file: "#{Rails.root}/public/404.html", status: 404
  end
end
