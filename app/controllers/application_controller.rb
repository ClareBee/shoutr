class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def current_user
    # calls original implementation w fallback of guest
    super || Guest.new
  end
end
